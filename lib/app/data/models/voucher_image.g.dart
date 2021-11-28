// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherImage _$VoucherImageFromJson(Map<String, dynamic> json) {
  return VoucherImage(
    voucherImageId: json['voucherImageId'] as int?,
    voucherImageUrl: json['voucherImageUrl'] as String?,
    createdDate: json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
  );
}

Map<String, dynamic> _$VoucherImageToJson(VoucherImage instance) =>
    <String, dynamic>{
      'voucherImageId': instance.voucherImageId,
      'voucherImageUrl': instance.voucherImageUrl,
      'createdDate': instance.createdDate?.toIso8601String(),
    };
