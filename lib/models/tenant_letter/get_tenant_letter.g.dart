// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_tenant_letter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTenantLetter _$GetTenantLetterFromJson(Map<String, dynamic> json) =>
    GetTenantLetter(
      data: (json['data'] as List<dynamic>)
          .map((e) => DatumTenantLetter.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as int,
    );

Map<String, dynamic> _$GetTenantLetterToJson(GetTenantLetter instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };
