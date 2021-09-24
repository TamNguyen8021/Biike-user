import 'package:json_annotation/json_annotation.dart';

/// This allows the `Trip` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'trip.g.dart';

// An annotation for the code generator to know that this class needs the
// JSON serialization logic to be generated.
@JsonSerializable()
class Trip {
  final int? tripId;
  final int? keerId;
  final int? bikerId;
  final int? routeId;
  final DateTime timeBook;
  final DateTime? timePickUp;
  final DateTime? timeFinished;
  final int? tripStatus;
  final String? numberPlate;
  final bool? isSchedule;
  final int? cancelPersonId;
  final String? cancelReason;

  Trip(
      this.tripId,
      this.keerId,
      this.bikerId,
      this.routeId,
      this.timeBook,
      this.timePickUp,
      this.timeFinished,
      this.tripStatus,
      this.numberPlate,
      this.isSchedule,
      this.cancelPersonId,
      this.cancelReason);

  /// A necessary factory constructor for creating a new Trip instance
  /// from a map. Pass the map to the generated `_$TripFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Trip.
  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$TripToJson`.
  Map<String, dynamic> toJson() => _$TripToJson(this);
}
