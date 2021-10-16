// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'starting_station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StartingStation _$StartingStationFromJson(Map<String, dynamic> json) {
  return StartingStation(
    json['stationId'] as int?,
    json['areaId'] as int?,
    json['startingPointName'] as String? ?? '',
    json['stationAddress'] as String?,
    json['isStationDeleted'] as bool?,
    json['longtitude'] as String?,
    json['latitude'] as String?,
  );
}

Map<String, dynamic> _$StartingStationToJson(StartingStation instance) =>
    <String, dynamic>{
      'stationId': instance.stationId,
      'areaId': instance.areaId,
      'startingPointName': instance.startingPointName,
      'stationAddress': instance.stationAddress,
      'isStationDeleted': instance.isStationDeleted,
      'longtitude': instance.longtitude,
      'latitude': instance.latitude,
    };
