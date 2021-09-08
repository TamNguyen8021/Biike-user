// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trip _$TripFromJson(Map<String, dynamic> json) {
  return Trip(
    json['tripId'] as int,
    json['customerPhoneNumber'] as String,
    json['driverPhoneNumber'] as String?,
    json['routeId'] as int,
    DateTime.parse(json['timeBook'] as String),
    json['timePickUp'] == null
        ? null
        : DateTime.parse(json['timePickUp'] as String),
    json['timeFinished'] == null
        ? null
        : DateTime.parse(json['timeFinished'] as String),
    json['status'] as int,
    json['numberPlate'] as String?,
    json['isSchedule'] as bool,
    json['cancelPersonPhoneNumber'] as String?,
  );
}

Map<String, dynamic> _$TripToJson(Trip instance) => <String, dynamic>{
      'tripId': instance.tripId,
      'customerPhoneNumber': instance.customerPhoneNumber,
      'driverPhoneNumber': instance.driverPhoneNumber,
      'routeId': instance.routeId,
      'timeBook': instance.timeBook.toIso8601String(),
      'timePickUp': instance.timePickUp?.toIso8601String(),
      'timeFinished': instance.timeFinished?.toIso8601String(),
      'status': instance.status,
      'numberPlate': instance.numberPlate,
      'isSchedule': instance.isSchedule,
      'cancelPersonPhoneNumber': instance.cancelPersonPhoneNumber,
    };
