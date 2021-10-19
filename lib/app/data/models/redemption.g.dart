// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'redemption.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Redemption _$RedemptionFromJson(Map<String, dynamic> json) {
  return Redemption(
    redemptionId: json['redemptionId'] as int,
    walletId: json['walletId'] as int,
    voucherId: json['voucherId'] as int,
    voucherCode: json['voucherCode'] as String,
    voucherPoint: json['voucherPoint'] as int,
    isUsed: json['isUsed'] as bool,
    redemptionDate: DateTime.parse(json['redemptionDate'] as String),
  );
}

Map<String, dynamic> _$RedemptionToJson(Redemption instance) =>
    <String, dynamic>{
      'redemptionId': instance.redemptionId,
      'walletId': instance.walletId,
      'voucherId': instance.voucherId,
      'voucherCode': instance.voucherCode,
      'voucherPoint': instance.voucherPoint,
      'isUsed': instance.isUsed,
      'redemptionDate': instance.redemptionDate.toIso8601String(),
    };
