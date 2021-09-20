// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trip _$TripFromJson(Map<String, dynamic> json) {
  return Trip(
    json['trip_id'] as int?,
    json['keer_id'] as int?,
    json['biker_id'] as int?,
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
    json['cancel_person_id'] as int?,
    json['cancel_reason'] as String?,
  );
}

Map<String, dynamic> _$TripToJson(Trip instance) => <String, dynamic>{
      'trip_id': instance.tripId,
      'keer_id': instance.keerId,
      'biker_id': instance.bikerId,
      'route_id': instance.routeId,
      'time_book': instance.timeBook.toIso8601String(),
      'time_pick_up': instance.timePickUp?.toIso8601String(),
      'time_finished': instance.timeFinished?.toIso8601String(),
      'trip_status': instance.tripStatus,
      'number_plate': instance.numberPlate,
      'is_schedule': instance.isSchedule,
      'cancel_person_id': instance.cancelPersonId,
      'cancel_reason': instance.cancelReason,
    };
