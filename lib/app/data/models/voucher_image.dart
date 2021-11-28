import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:get/get.dart';

/// This allows the `VoucherImage` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'voucher_image.g.dart';

// An annotation for the code generator to know that this class needs the
// JSON serialization logic to be generated.
@JsonSerializable()
class VoucherImage {
  int? voucherImageId;
  String? voucherImageUrl;
  DateTime? createdDate;

  VoucherImage(
      {required this.voucherImageId, this.voucherImageUrl, this.createdDate});

  /// A necessary factory constructor for creating a new VoucherImage instance
  /// from a map. Pass the map to the generated `_$VoucherFromJson()` constructor.
  /// The constructor is named after the source class, in this case, VoucherImage.
  factory VoucherImage.fromJson(Map<String, dynamic> json) =>
      _$VoucherImageFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$VoucherToJson`.
  Map<String, dynamic> toJson() => _$VoucherImageToJson(this);
}
