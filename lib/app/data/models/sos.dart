import 'package:json_annotation/json_annotation.dart';

/// This allows the `Bike` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'sos.g.dart';

// An annotation for the code generator to know that this class needs the
// JSON serialization logic to be generated.
@JsonSerializable()
class SOS {
  int? sosId;
  int? userId;
  String? sosName;
  String? sosPhone;
  DateTime? createdDate;

  SOS(
      {
        this.sosId,
      this.userId,
      this.sosName,
      this.sosPhone,
      this.createdDate
      });

  SOS.empty() {
    this.sosId = -1;
    this.userId = -1;
    this.sosName = '';
    this.sosPhone = '';
  }

  /// A necessary factory constructor for creating a new Bike instance
  /// from a map. Pass the map to the generated `_$BikeFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Bike.
  factory SOS.fromJson(Map<String, dynamic> json) => _$SOSFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$BikeToJson`.
  Map<String, dynamic> toJson() => _$SOSToJson(this);
}
