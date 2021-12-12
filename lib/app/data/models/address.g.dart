// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    addressId: json['addressId'] as int?,
    addressName: json['addressName'] as String?,
    addressDetail: json['addressDetail'] as String?,
    addressCoordinate: json['addressCoordinate'] as String?,
    createdDate: json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'addressId': instance.addressId,
      'addressName': instance.addressName,
      'addressDetail': instance.addressDetail,
      'addressCoordinate': instance.addressCoordinate,
      'createdDate': instance.createdDate?.toIso8601String(),
    };
