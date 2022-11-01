// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_letter3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LettersType _$LettersTypeFromJson(Map<String, dynamic> json) => LettersType(
      id: json['ID'] as int,
      createdAt: DateTime.parse(json['CreatedAt'] as String),
      updatedAt: DateTime.parse(json['UpdatedAt'] as String),
      deletedAt: json['DeletedAt'],
      lettersTypeId: json['id'] as int,
      letterName: json['letter_name'] as String,
      tenantId: json['tenant_id'] as int,
      subject: json['subject'] as String,
      date: DateTime.parse(json['date'] as String),
      lettersTypeCreatedAt: DateTime.parse(json['created_at'] as String),
      lettersTypeUpdatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$LettersTypeToJson(LettersType instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'CreatedAt': instance.createdAt.toIso8601String(),
      'UpdatedAt': instance.updatedAt.toIso8601String(),
      'DeletedAt': instance.deletedAt,
      'id': instance.lettersTypeId,
      'letter_name': instance.letterName,
      'tenant_id': instance.tenantId,
      'subject': instance.subject,
      'date': instance.date.toIso8601String(),
      'created_at': instance.lettersTypeCreatedAt.toIso8601String(),
      'updated_at': instance.lettersTypeUpdatedAt.toIso8601String(),
    };
