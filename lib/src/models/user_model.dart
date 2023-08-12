import 'dart:convert';

// Constants.
import 'package:flutter_boilerplate_project/src/commons/constants/fields.dart';
import 'package:flutter_boilerplate_project/src/commons/constants/numbers.dart';
import 'package:flutter_boilerplate_project/src/commons/constants/strings.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int id;
  String name;
  String email;
  String password;

  UserModel({
    this.id = Numbers.noValue,
    this.name = Strings.emptyString,
    this.email = Strings.emptyString,
    this.password = Strings.emptyString,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json[Fields.id] ?? Numbers.noValue,
    name: json[Fields.name] ?? Strings.emptyString,
    email: json[Fields.email] ?? Strings.emptyString,
    password: json[Fields.password] ?? Strings.emptyString,
  );

  Map<String, dynamic> toJson() => {
    Fields.id: id,
    Fields.name: name,
    Fields.email: email,
    Fields.password: password,
  };
}