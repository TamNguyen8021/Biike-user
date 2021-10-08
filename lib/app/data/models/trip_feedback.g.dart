// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripFeedback _$TripFeedbackFromJson(Map<String, dynamic> json) {
  return TripFeedback(
    json['feedbackId'] as int?,
    json['userId'] as int?,
    json['tripId'] as int?,
    json['feedbackContent'] as String? ?? '',
    (json['tripStar'] as num?)?.toDouble() ?? 0.0,
    json['criteria'] as String?,
  );
}

Map<String, dynamic> _$TripFeedbackToJson(TripFeedback instance) =>
    <String, dynamic>{
      'feedbackId': instance.feedbackId,
      'userId': instance.userId,
      'tripId': instance.tripId,
      'feedbackContent': instance.feedbackContent,
      'tripStar': instance.tripStar,
      'criteria': instance.criteria,
    };
