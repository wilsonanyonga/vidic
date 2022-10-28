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
      name: json['name'] as String,
      number: json['number'] as String,
      vidicEmail: json['vidic_email'] as String,
      officialEmail: json['official_email'] as String,
      about: json['about'] as String,
      floor: json['floor'] as String,
      rent: json['rent'] as String,
      escalation: json['escalation'] as String,
      pobox: json['pobox'] as String,
      leaseStartDate: DateTime.parse(json['leaseStartDate'] as String),
      leaseEndDate: DateTime.parse(json['leaseEndDate'] as String),
      active: json['active'] as String,
      password: json['password'] as String,
      datumCreatedAt: DateTime.parse(json['created_at'] as String),
      datumUpdatedAt: DateTime.parse(json['updated_at'] as String),
      statementTypes: (json['StatementTypes'] as List<dynamic>)
          .map((e) => StatementType.fromJson(e as Map<String, dynamic>))
          .toList(),
      invoiceTypes: json['InvoiceTypes'],
      lettersTypes: json['LettersTypes'],
      lettersTenantTypes: json['LettersTenantTypes'],
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'ID': instance.id,
      'CreatedAt': instance.createdAt.toIso8601String(),
      'UpdatedAt': instance.updatedAt.toIso8601String(),
      'DeletedAt': instance.deletedAt,
      'id': instance.datumId,
      'name': instance.name,
      'number': instance.number,
      'vidic_email': instance.vidicEmail,
      'official_email': instance.officialEmail,
      'about': instance.about,
      'floor': instance.floor,
      'rent': instance.rent,
      'escalation': instance.escalation,
      'pobox': instance.pobox,
      'leaseStartDate': instance.leaseStartDate.toIso8601String(),
      'leaseEndDate': instance.leaseEndDate.toIso8601String(),
      'active': instance.active,
      'password': instance.password,
      'created_at': instance.datumCreatedAt.toIso8601String(),
      'updated_at': instance.datumUpdatedAt.toIso8601String(),
      'StatementTypes': instance.statementTypes,
      'InvoiceTypes': instance.invoiceTypes,
      'LettersTypes': instance.lettersTypes,
      'LettersTenantTypes': instance.lettersTenantTypes,
    };
