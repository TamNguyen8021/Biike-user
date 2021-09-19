// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destination_station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DestinationStation _$DestinationStationFromJson(Map<String, dynamic> json) {
  return DestinationStation(
    json['station_id'] as int?,
    json['area_id'] as int?,
    json['destination_name'] as String,
    json['station_address'] as String?,
    json['is_station_deleted'] as bool?,
    json['longtitude'] as String?,
    json['latitude'] as String?,
  );
}

Map<String, dynamic> _$DestinationStationToJson(DestinationStation instance) =>
    <String, dynamic>{
      'station_id': instance.stationId,
      'area_id': instance.areaId,
      'destination_name': instance.destinationName,
      'station_address': instance.stationAddress,
      'is_station_deleted': instance.isStationDeleted,
      'longtitude': instance.longtitude,
      'latitude': instance.latitude,
    };
