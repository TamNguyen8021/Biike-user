import 'package:json_annotation/json_annotation.dart';

/// This allows the `DepartureStation` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'departure_station.g.dart';

// An annotation for the code generator to know that this class needs the
// JSON serialization logic to be generated.
@JsonSerializable()
class DepartureStation {
  int? stationId;
  int? areaId;

  @JsonKey(defaultValue: '')
  late String departureName;

  String? stationAddress;
  bool? isStationDeleted;

  @JsonKey(defaultValue: '')
  late String departureCoordinate;

  DepartureStation(
    this.stationId,
    this.areaId,
    this.departureName,
    this.stationAddress,
    this.isStationDeleted,
    this.departureCoordinate,
  );

  DepartureStation.empty() {
    this.departureName = '';
    this.departureCoordinate = '';
  }

  /// A necessary factory constructor for creating a new DepartureStation instance
  /// from a map. Pass the map to the generated `_$DepartureStationFromJson()` constructor.
  /// The constructor is named after the source class, in this case, DepartureStation.
  factory DepartureStation.fromJson(Map<String, dynamic> json) =>
      _$DepartureStationFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$DepartureStationToJson`.
  Map<String, dynamic> toJson() => _$DepartureStationToJson(this);
}
