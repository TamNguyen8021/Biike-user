// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destination_station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DestinationStation _$DestinationStationFromJson(Map<String, dynamic> json) {
  return DestinationStation(
    json['stationId'] as int?,
    json['areaId'] as int?,
    json['destinationName'] as String,
    json['stationAddress'] as String?,
    json['isStationDeleted'] as bool?,
    json['longtitude'] as String?,
    json['latitude'] as String?,
  );
}

Map<String, dynamic> _$DestinationStationToJson(DestinationStation instance) =>
    <String, dynamic>{
      'stationId': instance.stationId,
      'areaId': instance.areaId,
      'destinationName': instance.destinationName,
      'stationAddress': instance.stationAddress,
      'isStationDeleted': instance.isStationDeleted,
      'longtitude': instance.longtitude,
      'latitude': instance.latitude,
    };
