// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Route _$RouteFromJson(Map<String, dynamic> json) {
  return Route(
    json['route_id'] as int,
    json['starting_point_id'] as int,
    json['destination_id'] as int,
    json['default_price'] as int,
    json['is_route_deleted'] as bool,
  );
}

Map<String, dynamic> _$RouteToJson(Route instance) => <String, dynamic>{
      'route_id': instance.routeId,
      'starting_point_id': instance.startingPointId,
      'destination_id': instance.destinationId,
      'default_price': instance.defaultPrice,
      'is_route_deleted': instance.isRouteDeleted,
    };
