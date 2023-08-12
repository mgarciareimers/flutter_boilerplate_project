import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Models.
import 'package:flutter_boilerplate_project/src/models/user_model.dart';

// Constants.
import 'package:flutter_boilerplate_project/src/commons/constants/backend.dart';
import 'package:flutter_boilerplate_project/src/commons/constants/fields.dart';

class UserService with ChangeNotifier {
  UserService();

  // Method that gets the user.
  Future<Map<String, dynamic>> getUser(String id, String language) async {
    final String url = '${ Backend.baseUrl }/${ Backend.getUser }/$id';

    try {
      http.Response response = await http.get(Uri.parse(url), headers: {  });
      final decodedBody = json.decode(response.body);

      UserModel? user;

      if (decodedBody != null) {
        user = decodedBody[Fields.user] == null ? null : UserModel.fromJson(decodedBody[Fields.user]);
      }

      return {
        Fields.statusCode: response.statusCode,
        Fields.user: user
      };
    } catch(e) {
      return {
        Fields.statusCode: Backend.code500,
        Fields.user: null,
      };
    }
  }
}