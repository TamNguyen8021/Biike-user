import 'package:json_annotation/json_annotation.dart';

/// This allows the `Trip` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'trip.g.dart';

// An annotation for the code generator to know that this class needs the
// JSON serialization logic to be generated.
@JsonSerializable()
class Trip {
  @JsonKey(defaultValue: -1)
  late int tripId;

  int? keerId;
  int? bikerId;
  int? routeId;

  @JsonKey(defaultValue: '')
  late String createdDate;

  @JsonKey(defaultValue: '')
  late String bookTime;

  @JsonKey(defaultValue: '')
  late String timePickUp;

  @JsonKey(defaultValue: '')
  late String finishedTime;

  int? tripStatus;
  String? numberPlate;
  bool? isSchedule;
  int? cancelPersonId;
  String? cancelReason;

  Trip(
      this.tripId,
      this.keerId,
      this.bikerId,
      this.routeId,
      this.createdDate,
      this.bookTime,
      this.timePickUp,
      this.finishedTime,
      this.tripStatus,
      this.numberPlate,
      this.isSchedule,
      this.cancelPersonId,
      this.cancelReason);

  Trip.empty() {
    this.tripId = -1;
    this.createdDate = '';
    this.bookTime = '';
    this.timePickUp = '';
    this.finishedTime = '';
  }

  /// A necessary factory constructor for creating a new Trip instance
  /// from a map. Pass the map to the generated `_$TripFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Trip.
  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$TripToJson`.
  Map<String, dynamic> toJson() => _$TripToJson(this);
}
