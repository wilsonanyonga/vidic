// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetInvoice _$GetInvoiceFromJson(Map<String, dynamic> json) => GetInvoice(
      data: (json['data'] as List<dynamic>)
          .map((e) => DatumInvoice.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as int,
    );

Map<String, dynamic> _$GetInvoiceToJson(GetInvoice instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };
