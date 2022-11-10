// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_tenant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostTenant _$PostTenantFromJson(Map<String, dynamic> json) => PostTenant(
      data: DataPostTenant.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
    );

Map<String, dynamic> _$PostTenantToJson(PostTenant instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };
