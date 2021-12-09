// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bike_availability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BikeAvailability _$BikeAvailabilityFromJson(Map<String, dynamic> json) {
  return BikeAvailability(
    bikeAvailabilityId: json['bikeAvailabilityId'] as int?,
    userId: json['userId'] as int?,
    stationId: json['stationId'] as int?,
    stationName: json['stationName'] as String?,
    fromTime: json['fromTime'] == null
        ? null
        : DateTime.parse(json['fromTime'] as String),
    toTime: json['toTime'] == null
        ? null
        : DateTime.parse(json['toTime'] as String),
    createdDate: json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
  );
}

Map<String, dynamic> _$BikeAvailabilityToJson(BikeAvailability instance) =>
    <String, dynamic>{
      'bikeAvailabilityId': instance.bikeAvailabilityId,
      'userId': instance.userId,
      'stationId': instance.stationId,
      'stationName': instance.stationName,
      'fromTime': instance.fromTime?.toIso8601String(),
      'toTime': instance.toTime?.toIso8601String(),
      'createdDate': instance.createdDate?.toIso8601String(),
    };
