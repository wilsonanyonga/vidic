// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_occupancy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateOccupancy _$UpdateOccupancyFromJson(Map<String, dynamic> json) =>
    UpdateOccupancy(
      data: DataOccupancyUpdate.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
    );

Map<String, dynamic> _$UpdateOccupancyToJson(UpdateOccupancy instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };
