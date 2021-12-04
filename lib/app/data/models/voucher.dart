import 'package:bikes_user/app/data/models/voucher_image.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `Voucher` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'voucher.g.dart';

// An annotation for the code generator to know that this class needs the
// JSON serialization logic to be generated.
@JsonSerializable()
class Voucher {
  int voucherId;
  int voucherCategoryId;
  String voucherName;
  String brand;
  DateTime startDate;
  DateTime endDate;
  int? quantity;
  int? remaining;
  int? amountOfPoint;
  String description;
  String termsAndConditions;
  List<VoucherImage?> voucherImages;

  Voucher(
      {required this.voucherId,
      required this.voucherCategoryId,
      required this.voucherName,
      required this.brand,
      required this.startDate,
      required this.endDate,
      this.quantity,
      this.remaining,
      this.amountOfPoint,
      required this.description,
      required this.termsAndConditions,
      required this.voucherImages});

  /// A necessary factory constructor for creating a new Voucher instance
  /// from a map. Pass the map to the generated `_$VoucherFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Voucher.
  factory Voucher.fromJson(Map<String, dynamic> json) =>
      _$VoucherFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$VoucherToJson`.
  Map<String, dynamic> toJson() => _$VoucherToJson(this);

  void setAmountOfPoint(point) {
    this.amountOfPoint = point;
  }
}
