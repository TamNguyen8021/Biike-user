// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destination_station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DestinationStation _$DestinationStationFromJson(Map<String, dynamic> json) {
  return DestinationStation(
    json['stationId'] as int?,
    json['areaId'] as int?,
    json['destinationName'] as String? ?? '',
    json['stationAddress'] as String?,
    json['isStationDeleted'] as bool?,
    json['destinationCoordinate'] as String? ?? '',
  );
}

Map<String, dynamic> _$DestinationStationToJson(DestinationStation instance) =>
    <String, dynamic>{
      'stationId': instance.stationId,
      'areaId': instance.areaId,
      'destinationName': instance.destinationName,
      'stationAddress': instance.stationAddress,
      'isStationDeleted': instance.isStationDeleted,
      'destinationCoordinate': instance.destinationCoordinate,
    };
