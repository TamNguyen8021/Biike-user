import 'package:json_annotation/json_annotation.dart';

/// This allows the `Feedback` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'feedback.g.dart';

// An annotation for the code generator to know that this class needs the
// JSON serialization logic to be generated.
@JsonSerializable()
class Feedback {
  final int? feedbackId;
  final int? userId;
  final int? tripId;
  final String? feedbackContent;
  final double? tripStar;
  final String? criteria;

  Feedback(
    this.feedbackId,
    this.userId,
    this.tripId,
    this.feedbackContent,
    this.tripStar,
    this.criteria,
  );

  /// A necessary factory constructor for creating a new Feedback instance
  /// from a map. Pass the map to the generated `_$FeedbackFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Feedback.
  factory Feedback.fromJson(Map<String, dynamic> json) =>
      _$FeedbackFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$FeedbackToJson`.
  Map<String, dynamic> toJson() => _$FeedbackToJson(this);
}
