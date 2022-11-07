// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenants.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTenant _$GetTenantFromJson(Map<String, dynamic> json) => GetTenant(
      data: (json['data'] as List<dynamic>)
          .map((e) => DatumTenant.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as int,
    );

Map<String, dynamic> _$GetTenantToJson(GetTenant instance) => <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };
