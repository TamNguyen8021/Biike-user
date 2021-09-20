// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'starting_station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StartingStation _$StartingStationFromJson(Map<String, dynamic> json) {
  return StartingStation(
    json['station_id'] as int?,
    json['area_id'] as int?,
    json['starting_point_name'] as String,
    json['station_address'] as String?,
    json['is_station_deleted'] as bool?,
    json['longtitude'] as String?,
    json['latitude'] as String?,
  );
}

Map<String, dynamic> _$StartingStationToJson(StartingStation instance) =>
    <String, dynamic>{
      'station_id': instance.stationId,
      'area_id': instance.areaId,
      'starting_point_name': instance.startingPointName,
      'station_address': instance.stationAddress,
      'is_station_deleted': instance.isStationDeleted,
      'longtitude': instance.longtitude,
      'latitude': instance.latitude,
    };
