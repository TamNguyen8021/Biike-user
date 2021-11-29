// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feedback _$FeedbackFromJson(Map<String, dynamic> json) {
  return Feedback(
    feedbackId: json['feedbackId'] as int?,
    userId: json['userId'] as int?,
    tripId: json['tripId'] as int?,
    feedbackContent: json['feedbackContent'] as String?,
    tripStar: json['tripStar'] as int?,
    tripTip: json['tripTip'] as int?,
    criteria: json['criteria'] as String?,
    createdDate: json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
  );
}

Map<String, dynamic> _$FeedbackToJson(Feedback instance) => <String, dynamic>{
      'feedbackId': instance.feedbackId,
      'userId': instance.userId,
      'tripId': instance.tripId,
      'feedbackContent': instance.feedbackContent,
      'tripStar': instance.tripStar,
      'tripTip': instance.tripTip,
      'criteria': instance.criteria,
      'createdDate': instance.createdDate?.toIso8601String(),
    };
