import 'package:json_annotation/json_annotation.dart';

/// This allows the `DestinationStation` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'voucher.g.dart';

// An annotation for the code generator to know that this class needs the
// JSON serialization logic to be generated.
@JsonSerializable()
class Voucher {
  final int? voucherId;
  final int? voucherCategoryId;
  final String? voucherName;
  final String? brand;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? quantity;
  final int? remaining;
  final int? amountOfPoint;
  final String? description;
  final String? termsAndConditions;

  Voucher({
      this.voucherId,
      this.voucherCategoryId,
      this.voucherName,
      this.brand,
      this.startDate,
      this.endDate,
      this.quantity,
      this.remaining,
      this.amountOfPoint,
      this.description,
      this.termsAndConditions
  });

  /// A necessary factory constructor for creating a new DestinationStation instance
  /// from a map. Pass the map to the generated `_$DestinationStationFromJson()` constructor.
  /// The constructor is named after the source class, in this case, DestinationStation.
  factory Voucher.fromJson(Map<String, dynamic> json) =>
      _$VoucherFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$DestinationStationToJson`.
  Map<String, dynamic> toJson() => _$VoucherToJson(this);
}
