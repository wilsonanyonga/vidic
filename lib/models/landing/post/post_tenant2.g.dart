// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_tenant2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataPostTenant _$DataPostTenantFromJson(Map<String, dynamic> json) =>
    DataPostTenant(
      id: json['ID'] as int,
      createdAt: DateTime.parse(json['CreatedAt'] as String),
      updatedAt: DateTime.parse(json['UpdatedAt'] as String),
      deletedAt: json['DeletedAt'],
      dataId: json['id'] as int,
      name: json['name'] as String,
      number: json['number'] as String,
      vidicEmail: json['vidic_email'] as String,
      officialEmail: json['official_email'] as String,
      about: json['about'] as String,
      floor: json['floor'] as String,
      size: json['size'] as String,
      rent: json['rent'] as String,
      escalation: json['escalation'] as String,
      pobox: json['pobox'] as String,
      leaseStartDate: DateTime.parse(json['lease_start_date'] as String),
      leaseEndDate: DateTime.parse(json['lease_end_date'] as String),
      active: json['active'] as String,
      password: json['password'] as String,
      dataCreatedAt: DateTime.parse(json['created_at'] as String),
      dataUpdatedAt: DateTime.parse(json['updated_at'] as String),
      statementTypes: json['StatementTypes'],
      invoiceTypes: json['InvoiceTypes'],
      lettersTypes: json['LettersTypes'],
      lettersTenantTypes: json['LettersTenantTypes'],
    );

Map<String, dynamic> _$DataPostTenantToJson(DataPostTenant instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'CreatedAt': instance.createdAt.toIso8601String(),
      'UpdatedAt': instance.updatedAt.toIso8601String(),
      'DeletedAt': instance.deletedAt,
      'id': instance.dataId,
      'name': instance.name,
      'number': instance.number,
      'vidic_email': instance.vidicEmail,
      'official_email': instance.officialEmail,
      'about': instance.about,
      'floor': instance.floor,
      'size': instance.size,
      'rent': instance.rent,
      'escalation': instance.escalation,
      'pobox': instance.pobox,
      'lease_start_date': instance.leaseStartDate.toIso8601String(),
      'lease_end_date': instance.leaseEndDate.toIso8601String(),
      'active': instance.active,
      'password': instance.password,
      'created_at': instance.dataCreatedAt.toIso8601String(),
      'updated_at': instance.dataUpdatedAt.toIso8601String(),
      'StatementTypes': instance.statementTypes,
      'InvoiceTypes': instance.invoiceTypes,
      'LettersTypes': instance.lettersTypes,
      'LettersTenantTypes': instance.lettersTenantTypes,
    };
