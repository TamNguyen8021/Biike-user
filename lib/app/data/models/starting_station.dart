import 'package:json_annotation/json_annotation.dart';

/// This allows the `StartingStation` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'starting_station.g.dart';

// An annotation for the code generator to know that this class needs the
// JSON serialization logic to be generated.
@JsonSerializable(fieldRename: FieldRename.snake)
class StartingStation {
  final int? stationId;
  final int? areaId;
  final String startingPointName;
  final String? stationAddress;
  final bool? isStationDeleted;
  final String? longtitude;
  final String? latitude;

  StartingStation(
    this.stationId,
    this.areaId,
    this.startingPointName,
    this.stationAddress,
    this.isStationDeleted,
    this.longtitude,
    this.latitude,
  );

  /// A necessary factory constructor for creating a new StartingStation instance
  /// from a map. Pass the map to the generated `_$StartingStationFromJson()` constructor.
  /// The constructor is named after the source class, in this case, StartingStation.
  factory StartingStation.fromJson(Map<String, dynamic> json) =>
      _$StartingStationFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$StartingStationToJson`.
  Map<String, dynamic> toJson() => _$StartingStationToJson(this);
}
