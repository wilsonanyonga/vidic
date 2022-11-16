// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_letter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostLetter _$PostLetterFromJson(Map<String, dynamic> json) => PostLetter(
      data: DataLetter.fromJson(json['data'] as Map<String, dynamic>),
      filename: json['filename'] as String,
      message: json['message'] as String,
      status: json['status'] as int,
    );

Map<String, dynamic> _$PostLetterToJson(PostLetter instance) =>
    <String, dynamic>{
      'data': instance.data,
      'filename': instance.filename,
      'message': instance.message,
      'status': instance.status,
    };
