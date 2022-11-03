// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_letter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetLetter _$GetLetterFromJson(Map<String, dynamic> json) => GetLetter(
      data: (json['data'] as List<dynamic>)
          .map((e) => DatumLetter.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as int,
    );

Map<String, dynamic> _$GetLetterToJson(GetLetter instance) => <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };
