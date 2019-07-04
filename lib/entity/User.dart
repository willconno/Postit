

import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable(includeIfNull: false)
class User {

  String email;
  String phoneNumber;

  String providerId;
  String uid;
  String displayName;
  String photoUrl;

  User();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

class Me extends User {

  static final User _instance = Me._internal();

  factory Me() {
    return _instance;
  }

  Me._internal();
}