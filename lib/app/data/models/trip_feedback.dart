import 'package:json_annotation/json_annotation.dart';

/// This allows the `TripFeedback` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'trip_feedback.g.dart';

// An annotation for the code generator to know that this class needs the
// JSON serialization logic to be generated.
@JsonSerializable()
class TripFeedback {
  int? feedbackId;
  int? userId;
  int? tripId;

  @JsonKey(defaultValue: '')
  late String feedbackContent;

  @JsonKey(defaultValue: 0.0)
  late double tripStar;

  String? criteria;

  TripFeedback(
    this.feedbackId,
    this.userId,
    this.tripId,
    this.feedbackContent,
    this.tripStar,
    this.criteria,
  );

  TripFeedback.empty() {
    this.feedbackContent = '';
    this.tripStar = 0.0;
  }

  /// A necessary factory constructor for creating a new TripFeedback instance
  /// from a map. Pass the map to the generated `_$TripFeedbackFromJson()` constructor.
  /// The constructor is named after the source class, in this case, TripFeedback.
  factory TripFeedback.fromJson(Map<String, dynamic> json) =>
      _$TripFeedbackFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$TripFeedbackToJson`.
  Map<String, dynamic> toJson() => _$TripFeedbackToJson(this);
}
