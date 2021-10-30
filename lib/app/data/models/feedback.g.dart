// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feedback _$FeedbackFromJson(Map<String, dynamic> json) {
  return Feedback(
    feedbackId: json['feedbackId'] as int,
    userId: json['userId'] as int,
    tripId: json['tripId'] as int,
    feedbackContent: json['feedbackContent'] as String,
    tripStar: (json['tripStar'] as num).toInt(),
    criteria: json['criteria'] as String,
  );
}

Map<String, dynamic> _$FeedbackToJson(Feedback instance) => <String, dynamic>{
      // 'feedbackId': instance.feedbackId,
      'userId': instance.userId,
      'tripId': instance.tripId,
      'feedbackContent': instance.feedbackContent,
      'tripStar': instance.tripStar,
      'criteria': instance.criteria,
    };
