// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Station _$StationFromJson(Map<String, dynamic> json) {
  return Station(
    json['stationId'] as int,
    json['areaId'] as int,
    json['name'] as String,
    json['address'] as String,
    json['isDeleted'] as bool,
    json['longtitude'] as String,
    json['latitude'] as String,
  );
}

Map<String, dynamic> _$StationToJson(Station instance) => <String, dynamic>{
      'stationId': instance.stationId,
      'areaId': instance.areaId,
      'name': instance.name,
      'address': instance.address,
      'isDeleted': instance.isDeleted,
      'longtitude': instance.longtitude,
      'latitude': instance.latitude,
    };
