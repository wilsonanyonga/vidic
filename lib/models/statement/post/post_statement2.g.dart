// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_statement2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataStatement _$DataStatementFromJson(Map<String, dynamic> json) =>
    DataStatement(
      id: json['ID'] as int,
      createdAt: DateTime.parse(json['CreatedAt'] as String),
      updatedAt: DateTime.parse(json['UpdatedAt'] as String),
      deletedAt: json['DeletedAt'],
      dataId: json['id'] as int,
      statementName: json['statement_name'] as String,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      amount: json['amount'] as int,
      tenantId: json['tenant_id'] as int,
      dataCreatedAt: DateTime.parse(json['created_at'] as String),
      dataUpdatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$DataStatementToJson(DataStatement instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'CreatedAt': instance.createdAt.toIso8601String(),
      'UpdatedAt': instance.updatedAt.toIso8601String(),
      'DeletedAt': instance.deletedAt,
      'id': instance.dataId,
      'statement_name': instance.statementName,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'amount': instance.amount,
      'tenant_id': instance.tenantId,
      'created_at': instance.dataCreatedAt.toIso8601String(),
      'updated_at': instance.dataUpdatedAt.toIso8601String(),
    };
