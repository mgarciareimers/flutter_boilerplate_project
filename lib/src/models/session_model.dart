import 'dart:convert';

// Models.
import 'package:flutter_boilerplate_project/src/models/user_model.dart';

// Constants.
import 'package:flutter_boilerplate_project/src/commons/constants/fields.dart';

SessionModel userModelFromJson(String str) => SessionModel.fromJson(json.decode(str));

String userModelToJson(SessionModel data) => json.encode(data.toJson());

class SessionModel {
  UserModel? user;

  SessionModel({
    this.user,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) => SessionModel(
    user: json[Fields.user] == null ? null : UserModel.fromJson(json[Fields.user]),
  );

  Map<String, dynamic> toJson() => {
    Fields.user: user?.toJson(),
  };

  // Method that logs the user out.
  void logout() {
    user = null;
  }
}