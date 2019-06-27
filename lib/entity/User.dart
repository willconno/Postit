

import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable(includeIfNull: false)
class User {

  var username;
  var email;
  var mobile;
  var password;

  User();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}