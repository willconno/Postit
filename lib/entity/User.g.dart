// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..email = json['email'] as String
    ..phoneNumber = json['phoneNumber'] as String
    ..providerId = json['providerId'] as String
    ..uid = json['uid'] as String
    ..displayName = json['displayName'] as String
    ..photoUrl = json['photoUrl'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('email', instance.email);
  writeNotNull('phoneNumber', instance.phoneNumber);
  writeNotNull('providerId', instance.providerId);
  writeNotNull('uid', instance.uid);
  writeNotNull('displayName', instance.displayName);
  writeNotNull('photoUrl', instance.photoUrl);
  return val;
}
