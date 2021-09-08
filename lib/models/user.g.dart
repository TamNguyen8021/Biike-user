// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['userPhoneNumber'] as String,
    json['userEmail'] as String,
    json['name'] as String,
    json['avatar'] as String?,
    json['gender'] as int,
    json['status'] as int,
    json['lastLoginDevice'] as String,
    DateTime.parse(json['lastLoginTime'] as String),
    (json['star'] as num).toDouble(),
    DateTime.parse(json['createDate'] as String),
    json['isBikeVerified'] as bool,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userPhoneNumber': instance.userPhoneNumber,
      'userEmail': instance.userEmail,
      'name': instance.name,
      'avatar': instance.avatar,
      'gender': instance.gender,
      'status': instance.status,
      'lastLoginDevice': instance.lastLoginDevice,
      'lastLoginTime': instance.lastLoginTime.toIso8601String(),
      'star': instance.star,
      'createDate': instance.createDate.toIso8601String(),
      'isBikeVerified': instance.isBikeVerified,
    };
