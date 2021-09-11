// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trip _$TripFromJson(Map<String, dynamic> json) {
  return Trip(
    json['trip_id'] as int?,
    json['customer_phone_number'] as String?,
    json['driver_phone_number'] as String?,
    json['route_id'] as int?,
    DateTime.parse(json['time_book'] as String),
    json['time_pick_up'] == null
        ? null
        : DateTime.parse(json['time_pick_up'] as String),
    json['time_finished'] == null
        ? null
        : DateTime.parse(json['time_finished'] as String),
    json['trip_status'] as int?,
    json['number_plate'] as String?,
    json['is_schedule'] as bool?,
    json['cancel_person_phone_number'] as String?,
  );
}

Map<String, dynamic> _$TripToJson(Trip instance) => <String, dynamic>{
      'trip_id': instance.tripId,
      'customer_phone_number': instance.customerPhoneNumber,
      'driver_phone_number': instance.driverPhoneNumber,
      'route_id': instance.routeId,
      'time_book': instance.timeBook.toIso8601String(),
      'time_pick_up': instance.timePickUp?.toIso8601String(),
      'time_finished': instance.timeFinished?.toIso8601String(),
      'trip_status': instance.tripStatus,
      'number_plate': instance.numberPlate,
      'is_schedule': instance.isSchedule,
      'cancel_person_phone_number': instance.cancelPersonPhoneNumber,
    };
