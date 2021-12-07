// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bike.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bike _$BikeFromJson(Map<String, dynamic> json) {
  return Bike(
    bikeId: json['bikeId'] as int?,
    userId: json['userId'] as int?,
    bikeOwner: json['bikeOwner'] as String?,
    plateNumber: json['plateNumber'] as String?,
    color: json['color'] as String?,
    brand: json['brand'] as String?,
    bikeType: json['bikeType'] as String?,
    bikeVolume: json['bikeVolume'] as String?,
    plateNumberPicture: json['plateNumberPicture'] as String?,
    bikeLicensePicture: json['bikeLicensePicture'] as String?,
    bikePicture: json['bikePicture'] as String?,
    drivingLicenseBackPicture: json['drivingLicenseBackPicture'] as String?,
    drivingLicenseFrontPicture: json['drivingLicenseFrontPicture'] as String?,
    bikeStatus: json['bikeStatus'] as int?,
    failedVerificationReason: json['failedVerificationReason'] as String?,
  );
}

Map<String, dynamic> _$BikeToJson(Bike instance) => <String, dynamic>{
      'bikeId': instance.bikeId,
      'userId': instance.userId,
      'bikeOwner': instance.bikeOwner,
      'plateNumber': instance.plateNumber,
      'color': instance.color,
      'brand': instance.brand,
      'bikeType': instance.bikeType,
      'bikeVolume': instance.bikeVolume,
      'plateNumberPicture': instance.plateNumberPicture,
      'bikeLicensePicture': instance.bikeLicensePicture,
      'bikePicture': instance.bikePicture,
      'drivingLicenseBackPicture': instance.drivingLicenseBackPicture,
      'drivingLicenseFrontPicture': instance.drivingLicenseFrontPicture,
      'bikeStatus': instance.bikeStatus,
      'failedVerificationReason': instance.failedVerificationReason,
    };
