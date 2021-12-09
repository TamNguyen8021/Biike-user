import 'package:json_annotation/json_annotation.dart';

/// This allows the `BikeAvailability` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'bike_availability.g.dart';

// An annotation for the code generator to know that this class needs the
// JSON serialization logic to be generated.
@JsonSerializable()
class BikeAvailability {
  int? bikeAvailabilityId;
  int? userId;
  int? stationId;
  String? stationName;
  DateTime? fromTime;
  DateTime? toTime;
  DateTime? createdDate;

  BikeAvailability({
    this.bikeAvailabilityId,
    this.userId,
    this.stationId,
    this.stationName,
    this.fromTime,
    this.toTime,
    this.createdDate,
  });

  /// A necessary factory constructor for creating a new BikeAvailability instance
  /// from a map. Pass the map to the generated `_$BikeAvailabilityFromJson()` constructor.
  /// The constructor is named after the source class, in this case, BikeAvailability.
  factory BikeAvailability.fromJson(Map<String, dynamic> json) =>
      _$BikeAvailabilityFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$BikeAvailabilityToJson`.
  Map<String, dynamic> toJson() => _$BikeAvailabilityToJson(this);
}
