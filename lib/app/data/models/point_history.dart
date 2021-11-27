import 'package:json_annotation/json_annotation.dart';

/// This allows the `PointHistory` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'point_history.g.dart';

// An annotation for the code generator to know that this class needs the
// JSON serialization logic to be generated.
@JsonSerializable()
class PointHistory {
  int? pointHistoryId;
  int? userId;
  int? historyType;
  int? relatedId;
  int? point;
  int? totalPoint;
  String? description;
  DateTime? timeStamp;

  PointHistory({
    this.pointHistoryId,
    this.userId,
    this.historyType,
    this.relatedId,
    this.point,
    this.totalPoint,
    this.description,
    this.timeStamp
  });

  /// A necessary factory constructor for creating a new PointHistory instance
  /// from a map. Pass the map to the generated `_$PointHistoryFromJson()` constructor.
  /// The constructor is named after the source class, in this case, PointHistory.
  factory PointHistory.fromJson(Map<String, dynamic> json) =>
      _$PointHistoryFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$PointHistoryToJson`.
  Map<String, dynamic> toJson() => _$PointHistoryToJson(this);
}
