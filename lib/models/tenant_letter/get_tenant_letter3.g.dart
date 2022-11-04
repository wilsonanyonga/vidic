// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_tenant_letter3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LettersTenantType _$LettersTenantTypeFromJson(Map<String, dynamic> json) =>
    LettersTenantType(
      id: json['ID'] as int,
      createdAt: DateTime.parse(json['CreatedAt'] as String),
      updatedAt: DateTime.parse(json['UpdatedAt'] as String),
      deletedAt: json['DeletedAt'],
      lettersTenantTypeId: json['id'] as int,
      letterName: json['letter_name'] as String,
      tenantId: json['tenant_id'] as int,
      subject: json['subject'] as String,
      date: DateTime.parse(json['date'] as String),
      lettersTenantTypeCreatedAt: DateTime.parse(json['created_at'] as String),
      lettersTenantTypeUpdatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$LettersTenantTypeToJson(LettersTenantType instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'CreatedAt': instance.createdAt.toIso8601String(),
      'UpdatedAt': instance.updatedAt.toIso8601String(),
      'DeletedAt': instance.deletedAt,
      'id': instance.lettersTenantTypeId,
      'letter_name': instance.letterName,
      'tenant_id': instance.tenantId,
      'subject': instance.subject,
      'date': instance.date.toIso8601String(),
      'created_at': instance.lettersTenantTypeCreatedAt.toIso8601String(),
      'updated_at': instance.lettersTenantTypeUpdatedAt.toIso8601String(),
    };
