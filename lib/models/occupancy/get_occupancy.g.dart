// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_occupancy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetOccupancy _$GetOccupancyFromJson(Map<String, dynamic> json) => GetOccupancy(
      data: (json['data'] as List<dynamic>)
          .map((e) => DatumOccupancy.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as int,
    );

Map<String, dynamic> _$GetOccupancyToJson(GetOccupancy instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };
