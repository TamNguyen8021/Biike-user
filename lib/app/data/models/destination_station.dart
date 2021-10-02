import 'package:json_annotation/json_annotation.dart';

/// This allows the `DestinationStation` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'destination_station.g.dart';

// An annotation for the code generator to know that this class needs the
// JSON serialization logic to be generated.
@JsonSerializable()
class DestinationStation {
  final int? stationId;
  final int? areaId;
  final String destinationName;
  final String? stationAddress;
  final bool? isStationDeleted;
  final String? longtitude;
  final String? latitude;

  DestinationStation(
    this.stationId,
    this.areaId,
    this.destinationName,
    this.stationAddress,
    this.isStationDeleted,
    this.longtitude,
    this.latitude,
  );

  /// A necessary factory constructor for creating a new DestinationStation instance
  /// from a map. Pass the map to the generated `_$DestinationStationFromJson()` constructor.
  /// The constructor is named after the source class, in this case, DestinationStation.
  factory DestinationStation.fromJson(Map<String, dynamic> json) =>
      _$DestinationStationFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$DestinationStationToJson`.
  Map<String, dynamic> toJson() => _$DestinationStationToJson(this);
}
