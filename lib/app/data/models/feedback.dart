import 'package:json_annotation/json_annotation.dart';

/// This allows the `Feedback` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'feedback.g.dart';

// An annotation for the code generator to know that this class needs the
// JSON serialization logic to be generated.
@JsonSerializable()
class Feedback {
  int? feedbackId;
  int? userId;
  int? tripId;
  String? feedbackContent;
  int? tripStar;
  int? tripTip;
  String? criteria;
  DateTime? createdDate;

  Feedback({
    required this.feedbackId,
    required this.userId,
    required this.tripId,
    required this.feedbackContent,
    required this.tripStar,
    required this.tripTip,
    required this.criteria,
    required this.createdDate,
  });

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
