// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bike.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bike _$BikeFromJson(Map<String, dynamic> json) {
  return Bike(
    json['bike_id'] as int?,
    json['user_id'] as int?,
    json['number_plate'] as String?,
    json['color'] as String?,
    json['brand'] as String?,
    json['is_bike_deleted'] as bool?,
  );
}

Map<String, dynamic> _$BikeToJson(Bike instance) => <String, dynamic>{
      'bike_id': instance.bikeId,
      'user_id': instance.userId,
      'number_plate': instance.numberPlate,
      'color': instance.color,
      'brand': instance.brand,
      'is_bike_deleted': instance.isBikeDeleted,
    };
