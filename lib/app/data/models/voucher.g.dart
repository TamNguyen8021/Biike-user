// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Voucher _$VoucherFromJson(Map<String, dynamic> json) {
  return Voucher(
    voucherId: json['voucherId'] as int,
    voucherCategoryId: json['voucherCategoryId'] as int,
    voucherName: json['voucherName'] as String,
    brand: json['brand'] as String,
    startDate: DateTime.parse(json['startDate'] as String),
    endDate: DateTime.parse(json['endDate'] as String),
    quantity: json['quantity'] as int? ?? -1,
    remaining: json['remaining'] as int? ?? -1,
    amountOfPoint: json['amountOfPoint'] as int? ?? -1,
    description: json['description'] as String,
    termsAndConditions: json['termsAndConditions'] as String,
  );
}

Map<String, dynamic> _$VoucherToJson(Voucher instance) => <String, dynamic>{
  'voucherId': instance.voucherId,
  'voucherCategoryId': instance.voucherCategoryId,
  'voucherName': instance.voucherName,
  'brand': instance.brand,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
  'quantity': instance.quantity,
  'remaining': instance.remaining,
  'amountOfPoint': instance.amountOfPoint,
  'description': instance.description,
  'termsAndConditions': instance.termsAndConditions,
};
