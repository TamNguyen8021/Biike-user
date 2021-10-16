// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bike.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bike _$BikeFromJson(Map<String, dynamic> json) {
  return Bike(
    json['bikeId'] as int?,
    json['userId'] as int?,
    json['plateNumber'] as String?,
    json['color'] as String?,
    json['brand'] as String?,
    json['isBikeDeleted'] as bool?,
  );
}

Map<String, dynamic> _$BikeToJson(Bike instance) => <String, dynamic>{
      'bikeId': instance.bikeId,
      'userId': instance.userId,
      'plateNumber': instance.plateNumber,
      'color': instance.color,
      'brand': instance.brand,
      'isBikeDeleted': instance.isBikeDeleted,
    };
