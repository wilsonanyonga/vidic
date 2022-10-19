// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_statement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetStatement _$GetStatementFromJson(Map<String, dynamic> json) => GetStatement(
      data: (json['data'] as List<dynamic>)
          .map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as int,
    );

Map<String, dynamic> _$GetStatementToJson(GetStatement instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };
