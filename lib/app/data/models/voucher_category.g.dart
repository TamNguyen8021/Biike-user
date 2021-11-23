// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherCategory _$VoucherCategoryFromJson(Map<String, dynamic> json) {
  return VoucherCategory(
    voucherCategoryId: json['voucherCategoryId'] as int?,
    categoryName: json['categoryName'] as String? ?? '',
    createdDate: json['createdDate'] == null ? null : DateTime.parse(json['createdDate'] as String),
  );
}

Map<String, dynamic> _$VoucherCategoryToJson(VoucherCategory instance) => <String, dynamic>{
  'voucherCategoryId': instance.voucherCategoryId,
  'categoryName': instance.categoryName,
  'createdDate': instance.createdDate?.toIso8601String(),
};
