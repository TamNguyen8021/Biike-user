// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BiikeNoti _$NotificationFromJson(Map<dynamic, dynamic> json) {
  return BiikeNoti(
    receiverId: json['receiverId'] as int?,
    title: json['title'] as String?,
    content: json['content'] as String?,
    url: json['url'] as String?,
    createdDate: json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
    isRead: json['isRead'] as bool?,
  );
}

Map<String, dynamic> _$NotificationToJson(BiikeNoti instance) =>
    <String, dynamic>{
      'receiverId': instance.receiverId,
      'title': instance.title,
      'content': instance.content,
      'url': instance.url,
      'createdDate': instance.createdDate?.toIso8601String(),
      'isRead': instance.isRead,
    };
