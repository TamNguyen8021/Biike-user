// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['userPhoneNumber'] as String? ?? '',
    json['email'] as String? ?? '',
    json['userFullname'] as String? ?? 'kFinding',
    json['avatar'] as String? ?? '',
    json['gender'] as int? ?? -1,
    json['birthDate'] as String?,
    json['userStatus'] as int?,
    json['lastLoginDevice'] as String?,
    json['lastLoginTime'] == null
        ? null
        : DateTime.parse(json['lastLoginTime'] as String),
    (json['userStar'] as num?)?.toDouble() ?? 0.0,
    json['createDate'] == null
        ? null
        : DateTime.parse(json['createDate'] as String),
    json['isBikeVerified'] as bool?,
    json['isEmailVerified'] as bool?,
    json['isPhoneVerified'] as bool?,
  )
    ..userId = json['userId'] as int? ?? -1
    ..totalPoint = json['totalPoint'] as int? ?? 0;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'userPhoneNumber': instance.userPhoneNumber,
      'email': instance.email,
      'userFullname': instance.userFullname,
      'avatar': instance.avatar,
      'gender': instance.gender,
      'birthDate': instance.birthDate,
      'userStatus': instance.userStatus,
      'lastLoginDevice': instance.lastLoginDevice,
      'lastLoginTime': instance.lastLoginTime?.toIso8601String(),
      'userStar': instance.userStar,
      'totalPoint': instance.totalPoint,
      'createDate': instance.createDate?.toIso8601String(),
      'isBikeVerified': instance.isBikeVerified,
      'isEmailVerified': instance.isEmailVerified,
      'isPhoneVerified': instance.isPhoneVerified,
    };
