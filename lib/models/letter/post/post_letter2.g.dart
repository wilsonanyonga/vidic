// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_letter2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataLetter _$DataLetterFromJson(Map<String, dynamic> json) => DataLetter(
      id: json['ID'] as int,
      createdAt: DateTime.parse(json['CreatedAt'] as String),
      updatedAt: DateTime.parse(json['UpdatedAt'] as String),
      deletedAt: json['DeletedAt'],
      dataId: json['id'] as int,
      letterName: json['letter_name'] as String,
      tenantId: json['tenant_id'] as int,
      subject: json['subject'] as String,
      date: DateTime.parse(json['date'] as String),
      dataCreatedAt: DateTime.parse(json['created_at'] as String),
      dataUpdatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$DataLetterToJson(DataLetter instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'CreatedAt': instance.createdAt.toIso8601String(),
      'UpdatedAt': instance.updatedAt.toIso8601String(),
      'DeletedAt': instance.deletedAt,
      'id': instance.dataId,
      'letter_name': instance.letterName,
      'tenant_id': instance.tenantId,
      'subject': instance.subject,
      'date': instance.date.toIso8601String(),
      'created_at': instance.dataCreatedAt.toIso8601String(),
      'updated_at': instance.dataUpdatedAt.toIso8601String(),
    };
