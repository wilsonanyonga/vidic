// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_statement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostStatement _$PostStatementFromJson(Map<String, dynamic> json) =>
    PostStatement(
      data: DataStatement.fromJson(json['data'] as Map<String, dynamic>),
      filename: json['filename'] as String,
      message: json['message'] as String,
      status: json['status'] as int,
    );

Map<String, dynamic> _$PostStatementToJson(PostStatement instance) =>
    <String, dynamic>{
      'data': instance.data,
      'filename': instance.filename,
      'message': instance.message,
      'status': instance.status,
    };
