// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wallet _$WalletFromJson(Map<String, dynamic> json) {
  return Wallet(
    json['walletId'] as int?,
    json['userId'] as int?,
    json['fromDate'] == null
        ? null
        : DateTime.parse(json['fromDate'] as String),
    json['toDate'] == null ? null : DateTime.parse(json['toDate'] as String),
    json['point'] as int?,
    json['walletStatus'] as int?,
  );
}

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
      'walletId': instance.walletId,
      'userId': instance.userId,
      'fromDate': instance.fromDate?.toIso8601String(),
      'toDate': instance.toDate?.toIso8601String(),
      'point': instance.point,
      'walletStatus': instance.walletStatus,
    };
