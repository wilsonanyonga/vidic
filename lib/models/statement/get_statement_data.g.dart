// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_statement_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'],
      datumId: json['datumId'] as int,
      name: json['name'] as String,
      number: json['number'] as String,
      vidicEmail: json['vidicEmail'] as String,
      officialEmail: json['officialEmail'] as String,
      about: json['about'] as String,
      floor: json['floor'] as String,
      rent: json['rent'] as String,
      escalation: json['escalation'] as String,
      pobox: json['pobox'] as String,
      leaseStartDate: DateTime.parse(json['leaseStartDate'] as String),
      leaseEndDate: DateTime.parse(json['leaseEndDate'] as String),
      active: json['active'] as String,
      password: json['password'] as String,
      datumCreatedAt: DateTime.parse(json['datumCreatedAt'] as String),
      datumUpdatedAt: DateTime.parse(json['datumUpdatedAt'] as String),
      statementTypes: (json['statementTypes'] as List<dynamic>)
          .map((e) => StatementType.fromJson(e as Map<String, dynamic>))
          .toList(),
      invoiceTypes: json['invoiceTypes'],
      lettersTypes: json['lettersTypes'],
      lettersTenantTypes: json['lettersTenantTypes'],
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt,
      'datumId': instance.datumId,
      'name': instance.name,
      'number': instance.number,
      'vidicEmail': instance.vidicEmail,
      'officialEmail': instance.officialEmail,
      'about': instance.about,
      'floor': instance.floor,
      'rent': instance.rent,
      'escalation': instance.escalation,
      'pobox': instance.pobox,
      'leaseStartDate': instance.leaseStartDate.toIso8601String(),
      'leaseEndDate': instance.leaseEndDate.toIso8601String(),
      'active': instance.active,
      'password': instance.password,
      'datumCreatedAt': instance.datumCreatedAt.toIso8601String(),
      'datumUpdatedAt': instance.datumUpdatedAt.toIso8601String(),
      'statementTypes': instance.statementTypes,
      'invoiceTypes': instance.invoiceTypes,
      'lettersTypes': instance.lettersTypes,
      'lettersTenantTypes': instance.lettersTenantTypes,
    };
