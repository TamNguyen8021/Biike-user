// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SOS _$SOSFromJson(Map<String, dynamic> json) {
  return SOS(
    sosId: json['sosId'] as int?,
    userId: json['userId'] as int?,
    sosName: json['sosName'] as String?,
    sosPhone: json['sosPhone'] as String?,
    createdDate: json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
  );
}

Map<String, dynamic> _$SOSToJson(SOS instance) => <String, dynamic>{
      'sosId': instance.sosId,
      'userId': instance.userId,
      'sosName': instance.sosName,
      'sosPhone': instance.sosPhone,
      'createdDate': instance.createdDate?.toIso8601String(),
    };
