// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trip _$TripFromJson(Map<String, dynamic> json) {
  return Trip(
    json['tripId'] as int? ?? -1,
    json['keerId'] as int?,
    json['bikerId'] as int?,
    json['routeId'] as int?,
    json['createdTime'] as String? ?? '',
    json['timeBook'] as String? ?? '',
    json['timePickUp'] as String? ?? '',
    json['timeFinished'] as String? ?? '',
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
      'createdTime': instance.createdTime,
      'timeBook': instance.timeBook,
      'timePickUp': instance.timePickUp,
      'timeFinished': instance.timeFinished,
      'tripStatus': instance.tripStatus,
      'numberPlate': instance.numberPlate,
      'isSchedule': instance.isSchedule,
      'cancelPersonId': instance.cancelPersonId,
      'cancelReason': instance.cancelReason,
    };
