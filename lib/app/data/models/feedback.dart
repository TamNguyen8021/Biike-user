import 'package:json_annotation/json_annotation.dart';

part 'feedback.g.dart';

@JsonSerializable()
class Feedback {
  final int feedbackId;
  final int userId;
  final int tripId;
  final String feedbackContent;
  final int tripStar;
  final String criteria;

  Feedback({required this.feedbackId, required this.userId, required this.tripId, required this.feedbackContent,
    required this.tripStar, required this.criteria});

  factory Feedback.fromJson(Map<String, dynamic> json) => _$FeedbackFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackToJson(this);
}