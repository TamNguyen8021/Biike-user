// To parse this JSON data, do
//
//     final customRedemption = customRedemptionFromJson(jsonString);

import 'dart:convert';

CustomRedemption customRedemptionFromJson(String str) => CustomRedemption.fromJson(json.decode(str));

String customRedemptionToJson(CustomRedemption data) => json.encode(data.toJson());

class CustomRedemption {
  CustomRedemption({
    required this.voucherId,
    required this.voucherCategoryId,
    required this.voucherName,
    required this.brand,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.termsAndConditions,
    required this.redemptionId,
    required this.walletId,
    required this.voucherCode,
    required this.voucherPoint,
    required this.isUsed,
    required this.redemptionDate,
  });

  int voucherId;
  int voucherCategoryId;
  String voucherName;
  String brand;
  DateTime startDate;
  DateTime endDate;
  String description;
  String termsAndConditions;
  int redemptionId;
  int walletId;
  String voucherCode;
  int voucherPoint;
  bool isUsed;
  DateTime redemptionDate;

  factory CustomRedemption.fromJson(Map<String, dynamic> json) => CustomRedemption(
    voucherId: json["voucherId"],
    voucherCategoryId: json["voucherCategoryId"],
    voucherName: json["voucherName"],
    brand: json["brand"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    description: json["description"],
    termsAndConditions: json["termsAndConditions"],
    redemptionId: json["redemptionId"],
    walletId: json["walletId"],
    voucherCode: json["voucherCode"],
    voucherPoint: json["voucherPoint"],
    isUsed: json["isUsed"],
    redemptionDate: DateTime.parse(json["redemptionDate"]),
  );

  Map<String, dynamic> toJson() => {
    "voucherId": voucherId,
    "voucherCategoryId": voucherCategoryId,
    "voucherName": voucherName,
    "brand": brand,
    "startDate": startDate.toIso8601String(),
    "endDate": endDate.toIso8601String(),
    "description": description,
    "termsAndConditions": termsAndConditions,
    "redemptionId": redemptionId,
    "walletId": walletId,
    "voucherCode": voucherCode,
    "voucherPoint": voucherPoint,
    "isUsed": isUsed,
    "redemptionDate": redemptionDate.toIso8601String(),
  };
}
