// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trip _$TripFromJson(Map<String, dynamic> json) {
  return Trip(
    json['tripId'] as int?,
    json['keerId'] as int?,
    json['bikerId'] as int?,
    json['routeId'] as int?,
    DateTime.parse(json['timeBook'] as String),
    json['timePickUp'] == null
        ? null
        : DateTime.parse(json['timePickUp'] as String),
    json['timeFinished'] == null
        ? null
        : DateTime.parse(json['timeFinished'] as String),
    json['tripStatus'] as int?,
    json['numberPlate'] as String?,
    json['isSchedule'] as bool?,
    json['cancelPersonId'] as int?,
    json['cancelReason'] as String?,
  );
}

Map<String, dynamic> _$TripToJson(Trip instance) => <String, dynamic>{
      'tripId': instance.tripId,
      'keerId': instance.keerId,
      'bikerId': instance.bikerId,
      'routeId': instance.routeId,
      'timeBook': instance.timeBook.toIso8601String(),
      'timePickUp': instance.timePickUp?.toIso8601String(),
      'timeFinished': instance.timeFinished?.toIso8601String(),
      'tripStatus': instance.tripStatus,
      'numberPlate': instance.numberPlate,
      'isSchedule': instance.isSchedule,
      'cancelPersonId': instance.cancelPersonId,
      'cancelReason': instance.cancelReason,
    };
