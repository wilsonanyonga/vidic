// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_occupancy2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataOccupancyUpdate _$DataOccupancyUpdateFromJson(Map<String, dynamic> json) =>
    DataOccupancyUpdate(
      id: json['ID'] as int,
      createdAt: DateTime.parse(json['CreatedAt'] as String),
      updatedAt: DateTime.parse(json['UpdatedAt'] as String),
      deletedAt: json['DeletedAt'],
      dataId: json['id'] as int,
      floor: json['floor'] as int,
      occupancy: json['occupancy'] as int,
      capacity: json['capacity'] as int,
      dataCreatedAt: DateTime.parse(json['created_at'] as String),
      dataUpdatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$DataOccupancyUpdateToJson(
        DataOccupancyUpdate instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'CreatedAt': instance.createdAt.toIso8601String(),
      'UpdatedAt': instance.updatedAt.toIso8601String(),
      'DeletedAt': instance.deletedAt,
      'id': instance.dataId,
      'floor': instance.floor,
      'occupancy': instance.occupancy,
      'capacity': instance.capacity,
      'created_at': instance.dataCreatedAt.toIso8601String(),
      'updated_at': instance.dataUpdatedAt.toIso8601String(),
    };
