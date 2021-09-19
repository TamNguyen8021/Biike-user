import 'package:json_annotation/json_annotation.dart';

/// This allows the `Bike` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'bike.g.dart';

// An annotation for the code generator to know that this class needs the
// JSON serialization logic to be generated.
@JsonSerializable(fieldRename: FieldRename.snake)
class Bike {
  final int? bikeId;
  final int? userId;
  final String? numberPlate;
  final String? color;
  final String? brand;
  final bool? isBikeDeleted;

  Bike(
    this.bikeId,
    this.userId,
    this.numberPlate,
    this.color,
    this.brand,
    this.isBikeDeleted,
  );

  /// A necessary factory constructor for creating a new Bike instance
  /// from a map. Pass the map to the generated `_$BikeFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Bike.
  factory Bike.fromJson(Map<String, dynamic> json) => _$BikeFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$BikeToJson`.
  Map<String, dynamic> toJson() => _$BikeToJson(this);
}
