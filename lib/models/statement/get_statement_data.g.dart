// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_statement_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: json['ID'] as int,
      createdAt: DateTime.parse(json['CreatedAt'] as String),
      updatedAt: DateTime.parse(json['UpdatedAt'] as String),
      deletedAt: json['DeletedAt'],
      datumId: json['id'] as int,
      statementName: json['statement_name'] as String,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      amount: json['amount'] as int,
      tenantId: json['tenant_id'] as int,
      datumCreatedAt: DateTime.parse(json['created_at'] as String),
      datumUpdatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'ID': instance.id,
      'CreatedAt': instance.createdAt.toIso8601String(),
      'UpdatedAt': instance.updatedAt.toIso8601String(),
      'DeletedAt': instance.deletedAt,
      'id': instance.datumId,
      'statement_name': instance.statementName,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'amount': instance.amount,
      'tenant_id': instance.tenantId,
      'created_at': instance.datumCreatedAt.toIso8601String(),
      'updated_at': instance.datumUpdatedAt.toIso8601String(),
    };
