// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Area _$AreaFromJson(Map<String, dynamic> json) {
  return Area(
    json['areaId'] as int,
    json['name'] as String,
    json['isDeleted'] as bool,
  );
}

Map<String, dynamic> _$AreaToJson(Area instance) => <String, dynamic>{
      'areaId': instance.areaId,
      'name': instance.name,
      'isDeleted': instance.isDeleted,
    };
