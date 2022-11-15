// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostInvoice _$PostInvoiceFromJson(Map<String, dynamic> json) => PostInvoice(
      data: DataInvoice.fromJson(json['data'] as Map<String, dynamic>),
      filename: json['filename'] as String,
      message: json['message'] as String,
      status: json['status'] as int,
    );

Map<String, dynamic> _$PostInvoiceToJson(PostInvoice instance) =>
    <String, dynamic>{
      'data': instance.data,
      'filename': instance.filename,
      'message': instance.message,
      'status': instance.status,
    };
