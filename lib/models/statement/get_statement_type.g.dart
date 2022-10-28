// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_statement_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatementType _$StatementTypeFromJson(Map<String, dynamic> json) =>
    StatementType(
      id: json['ID'] as int,
      createdAt: DateTime.parse(json['CreatedAt'] as String),
      updatedAt: DateTime.parse(json['UpdatedAt'] as String),
      deletedAt: json['DeletedAt'],
      statementTypeId: json['id'] as int,
      statementName: json['statement_name'] as String?,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      amount: json['amount'] as int,
      tenantId: json['tenant_id'] as int,
      statementTypeCreatedAt: DateTime.parse(json['created_at'] as String),
      statementTypeUpdatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$StatementTypeToJson(StatementType instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'CreatedAt': instance.createdAt.toIso8601String(),
      'UpdatedAt': instance.updatedAt.toIso8601String(),
      'DeletedAt': instance.deletedAt,
      'id': instance.statementTypeId,
      'statement_name': instance.statementName,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'amount': instance.amount,
      'tenant_id': instance.tenantId,
      'created_at': instance.statementTypeCreatedAt.toIso8601String(),
      'updated_at': instance.statementTypeUpdatedAt.toIso8601String(),
    };
