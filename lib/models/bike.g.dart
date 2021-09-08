// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bike.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bike _$BikeFromJson(Map<String, dynamic> json) {
  return Bike(
    json['bikeId'] as int,
    json['userPhoneNumber'] as String,
    json['numberPlate'] as String,
    json['color'] as String,
    json['brand'] as String,
    json['isDeleted'] as bool,
  );
}

Map<String, dynamic> _$BikeToJson(Bike instance) => <String, dynamic>{
      'bikeId': instance.bikeId,
      'userPhoneNumber': instance.userPhoneNumber,
      'numberPlate': instance.numberPlate,
      'color': instance.color,
      'brand': instance.brand,
      'isDeleted': instance.isDeleted,
    };
