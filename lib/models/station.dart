import 'package:json_annotation/json_annotation.dart';

/// This allows the `Station` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'station.g.dart';

// An annotation for the code generator to know that this class needs the
// JSON serialization logic to be generated.
@JsonSerializable()
class Station {
  final int stationId;
  final int areaId;
  final String name;
  final String address;
  final bool isDeleted;
  final String longtitude;
  final String latitude;

  Station(
    this.stationId,
    this.areaId,
    this.name,
    this.address,
    this.isDeleted,
    this.longtitude,
    this.latitude,
  );

  /// A necessary factory constructor for creating a new Station instance
  /// from a map. Pass the map to the generated `_$StationFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Station.
  factory Station.fromJson(Map<String, dynamic> json) =>
      _$StationFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$StationToJson`.
  Map<String, dynamic> toJson() => _$StationToJson(this);
}
