// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feedback _$FeedbackFromJson(Map<String, dynamic> json) {
  return Feedback(
    json['feedbackId'] as int?,
    json['userId'] as int?,
    json['tripId'] as int?,
    json['feedbackContent'] as String?,
    (json['tripStar'] as num?)?.toDouble(),
    json['criteria'] as String?,
  );
}

Map<String, dynamic> _$FeedbackToJson(Feedback instance) => <String, dynamic>{
      'feedbackId': instance.feedbackId,
      'userId': instance.userId,
      'tripId': instance.tripId,
      'feedbackContent': instance.feedbackContent,
      'tripStar': instance.tripStar,
      'criteria': instance.criteria,
    };
