// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Area _$AreaFromJson(Map<String, dynamic> json) {
  return Area(
    json['area_id'] as int,
    json['area_name'] as String,
    json['is_area_deleted'] as bool,
  );
}

Map<String, dynamic> _$AreaToJson(Area instance) => <String, dynamic>{
      'area_id': instance.areaId,
      'area_name': instance.areaName,
      'is_area_deleted': instance.isAreaDeleted,
    };
