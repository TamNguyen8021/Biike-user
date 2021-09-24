// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['userPhoneNumber'] as String? ?? '',
    json['userEmail'] as String? ?? '',
    json['userFullname'] as String? ?? 'kFinding',
    json['avatar'] as String? ?? 'assets/images/loading.svg',
    json['gender'] as int? ?? -1,
    json['birthDate'] == null
        ? null
        : DateTime.parse(json['birthDate'] as String),
    json['userStatus'] as int?,
    json['lastLoginDevice'] as String?,
    json['lastLoginTime'] == null
        ? null
        : DateTime.parse(json['lastLoginTime'] as String),
    (json['userStar'] as num?)?.toDouble(),
    json['createDate'] == null
        ? null
        : DateTime.parse(json['createDate'] as String),
    json['isBikeVerified'] as bool?,
  )..userId = json['userId'] as int?;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'userPhoneNumber': instance.userPhoneNumber,
      'userEmail': instance.userEmail,
      'userFullname': instance.userFullname,
      'avatar': instance.avatar,
      'gender': instance.gender,
      'birthDate': instance.birthDate?.toIso8601String(),
      'userStatus': instance.userStatus,
      'lastLoginDevice': instance.lastLoginDevice,
      'lastLoginTime': instance.lastLoginTime?.toIso8601String(),
      'userStar': instance.userStar,
      'createDate': instance.createDate?.toIso8601String(),
      'isBikeVerified': instance.isBikeVerified,
    };
