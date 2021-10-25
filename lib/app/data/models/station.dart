import 'package:json_annotation/json_annotation.dart';

/// This allows the `Station` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'station.g.dart';

// An annotation for the code generator to know that this class needs the
// JSON serialization logic to be generated.
@JsonSerializable()
class Station {
  int? stationId;
  int? areaId;

  @JsonKey(defaultValue: '')
  late String name;

  String? address;

  @JsonKey(defaultValue: '')
  late String coordinate;

  Station(
    this.stationId,
    this.areaId,
    this.name,
    this.address,
    this.coordinate,
  );

  Station.empty() {
    this.stationId = -1;
    this.name = '';
    this.coordinate = '';
  }

  Station.boilerplate(name) {
    this.stationId = -1;
    this.name = name;
    this.coordinate = '';
  }

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
