// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_occupancy2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatumOccupancy _$DatumOccupancyFromJson(Map<String, dynamic> json) =>
    DatumOccupancy(
      id: json['ID'] as int,
      createdAt: DateTime.parse(json['CreatedAt'] as String),
      updatedAt: DateTime.parse(json['UpdatedAt'] as String),
      deletedAt: json['DeletedAt'],
      datumId: json['id'] as int,
      floor: json['floor'] as int,
      occupancy: json['occupancy'] as int,
      capacity: json['capacity'] as int,
      datumCreatedAt: DateTime.parse(json['created_at'] as String),
      datumUpdatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$DatumOccupancyToJson(DatumOccupancy instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'CreatedAt': instance.createdAt.toIso8601String(),
      'UpdatedAt': instance.updatedAt.toIso8601String(),
      'DeletedAt': instance.deletedAt,
      'id': instance.datumId,
      'floor': instance.floor,
      'occupancy': instance.occupancy,
      'capacity': instance.capacity,
      'created_at': instance.datumCreatedAt.toIso8601String(),
      'updated_at': instance.datumUpdatedAt.toIso8601String(),
    };
