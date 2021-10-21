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
    json['createdDate'] as String? ?? '',
    json['bookTime'] as String? ?? '',
    json['timePickUp'] as String? ?? '',
    json['finishedTime'] as String? ?? '',
    json['tripStatus'] as int?,
    json['plateNumber'] as String?,
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
      'createdDate': instance.createdDate,
      'bookTime': instance.bookTime,
      'timePickUp': instance.timePickUp,
      'finishedTime': instance.finishedTime,
      'tripStatus': instance.tripStatus,
      'plateNumber': instance.plateNumber,
      'isSchedule': instance.isSchedule,
      'cancelPersonId': instance.cancelPersonId,
      'cancelReason': instance.cancelReason,
    };
