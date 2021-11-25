// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) {
  return Notification(
      notiId: json['notiId'] as int?,
      receiverId: json['receiverId'] as int?,
      url: json['url'] as String? ?? '',
      timeSent: json['timeSent'] == null
          ? null
          : DateTime.parse(json['timeSent'] as String),
      isRead: json['isRead'] as bool?);
}

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'notiId': instance.notiId,
      'receiverId': instance.receiverId,
      'url': instance.url,
      'timeSent': instance.timeSent?.toIso8601String(),
      'isRead': instance.isRead
    };
