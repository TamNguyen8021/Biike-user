// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointHistory _$PointHistoryFromJson(Map<String, dynamic> json) {
  return PointHistory(
    pointHistoryId: json['pointHistoryId'] as int?,
    userId: json['userId'] as int?,
    historyType: json['historyType'] as int?,
    relatedId: json['relatedId'] as int?,
    point: json['point'] as int?,
    totalPoint: json['totalPoint'] as int?,
    description: json['description'] as String?,
    timeStamp: json['timeStamp'] == null
        ? null
        : DateTime.parse(json['timeStamp'] as String),
  );
}

Map<String, dynamic> _$PointHistoryToJson(PointHistory instance) =>
    <String, dynamic>{
      'pointHistoryId': instance.pointHistoryId,
      'userId': instance.userId,
      'historyType': instance.historyType,
      'relatedId': instance.relatedId,
      'point': instance.point,
      'totalPoint': instance.totalPoint,
      'description': instance.description,
      'timeStamp': instance.timeStamp?.toIso8601String(),
    };
