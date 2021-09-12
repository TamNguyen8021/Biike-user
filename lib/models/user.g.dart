// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['user_phone_number'] as String?,
    json['user_email'] as String?,
    json['user_fullname'] as String? ?? 'Đang tìm...',
    json['avatar'] as String? ?? 'assets/images/loading.svg',
    json['gender'] as int?,
    json['user_status'] as int?,
    json['last_login_device'] as String?,
    json['last_login_time'] == null
        ? null
        : DateTime.parse(json['last_login_time'] as String),
    (json['user_star'] as num?)?.toDouble(),
    json['create_date'] == null
        ? null
        : DateTime.parse(json['create_date'] as String),
    json['is_bike_verified'] as bool?,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'user_phone_number': instance.userPhoneNumber,
      'user_email': instance.userEmail,
      'user_fullname': instance.userFullname,
      'avatar': instance.avatar,
      'gender': instance.gender,
      'user_status': instance.userStatus,
      'last_login_device': instance.lastLoginDevice,
      'last_login_time': instance.lastLoginTime?.toIso8601String(),
      'user_star': instance.userStar,
      'create_date': instance.createDate?.toIso8601String(),
      'is_bike_verified': instance.isBikeVerified,
    };
