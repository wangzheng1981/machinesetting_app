// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..username = json['username'] as String
    ..userEmail = json['userEmail'] as String
    ..isLogin = json['isLogin'] as bool;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
      'userEmail': instance.userEmail,
      'isLogin': instance.isLogin
    };
