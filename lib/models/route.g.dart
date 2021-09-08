// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Route _$RouteFromJson(Map<String, dynamic> json) {
  return Route(
    json['routeId'] as int,
    json['startingPointId'] as int,
    json['destinationId'] as int,
    json['defaultPrice'] as int,
    json['isDeleted'] as bool,
  );
}

Map<String, dynamic> _$RouteToJson(Route instance) => <String, dynamic>{
      'routeId': instance.routeId,
      'startingPointId': instance.startingPointId,
      'destinationId': instance.destinationId,
      'defaultPrice': instance.defaultPrice,
      'isDeleted': instance.isDeleted,
    };
