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
    isBikeDeleted: json['isBikeDeleted'] as bool?,
    plateNumberPicture: json['plateNumberPicture'] as String?,
    bikeLicensePicture: json['bikeLicensePicture'] as String?,
    bikePicture: json['bikePicture'] as String?,
  );
}

Map<String, dynamic> _$BikeToJson(Bike instance) => <String, dynamic>{
      'bikeId': instance.bikeId,
      'userId': instance.userId,
      'bikeOwner': instance.bikeOwner,
      'plateNumber': instance.plateNumber,
      'color': instance.color,
      'brand': instance.brand,
      'plateNumberPicture': instance.plateNumberPicture,
      'bikeLicensePicture': instance.bikeLicensePicture,
      'bikePicture': instance.bikePicture,
      'isBikeDeleted': instance.isBikeDeleted,
    };
