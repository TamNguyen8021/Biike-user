import 'package:json_annotation/json_annotation.dart';

/// This allows the `Address` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'address.g.dart';

// An annotation for the code generator to know that this class needs the
// JSON serialization logic to be generated.
@JsonSerializable()
class Address {
  int? addressId;
  String? addressName;
  String? addressDetail;
  String? addressCoordinate;
  DateTime? createdDate;

  Address(
      {required this.addressId,
      required this.addressName,
      required this.addressDetail,
      required this.addressCoordinate,
      required this.createdDate});

  /// A necessary factory constructor for creating a new Address instance
  /// from a map. Pass the map to the generated `_$AddressFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Address.
  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$AddressToJson`.
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
