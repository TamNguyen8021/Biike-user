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
    quantity: json['quantity'] as int?,
    remaining: json['remaining'] as int?,
    amountOfPoint: json['amountOfPoint'] as int?,
    description: json['description'] as String,
    termsAndConditions: json['termsAndConditions'] as String,
    voucherAddresses: (json['voucherAddresses'] as List<dynamic>)
        .map((e) =>
            e == null ? null : Address.fromJson(e as Map<String, dynamic>))
        .toList(),
    voucherImages: (json['voucherImages'] as List<dynamic>)
        .map((e) =>
            e == null ? null : VoucherImage.fromJson(e as Map<String, dynamic>))
        .toList(),
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
      'voucherAddresses': instance.voucherAddresses,
      'voucherImages': instance.voucherImages,
    };
