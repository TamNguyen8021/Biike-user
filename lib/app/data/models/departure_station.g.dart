// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'departure_station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepartureStation _$DepartureStationFromJson(Map<String, dynamic> json) {
  return DepartureStation(
    json['stationId'] as int?,
    json['areaId'] as int?,
    json['departureName'] as String? ?? '',
    json['stationAddress'] as String?,
    json['isStationDeleted'] as bool?,
    json['departureCoordinate'] as String? ?? '',
  );
}

Map<String, dynamic> _$DepartureStationToJson(DepartureStation instance) =>
    <String, dynamic>{
      'stationId': instance.stationId,
      'areaId': instance.areaId,
      'departureName': instance.departureName,
      'stationAddress': instance.stationAddress,
      'isStationDeleted': instance.isStationDeleted,
      'departureCoordinate': instance.departureCoordinate,
    };
