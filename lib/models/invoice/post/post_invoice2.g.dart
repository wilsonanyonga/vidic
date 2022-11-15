// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_invoice2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataInvoice _$DataInvoiceFromJson(Map<String, dynamic> json) => DataInvoice(
      id: json['ID'] as int,
      createdAt: DateTime.parse(json['CreatedAt'] as String),
      updatedAt: DateTime.parse(json['UpdatedAt'] as String),
      deletedAt: json['DeletedAt'],
      dataId: json['id'] as int,
      invoiceName: json['invoice_name'] as String,
      month: json['month'] as String,
      amount: json['amount'] as int,
      purpose: json['purpose'] as String,
      tenantId: json['tenant_id'] as int,
      dataCreatedAt: DateTime.parse(json['created_at'] as String),
      dataUpdatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$DataInvoiceToJson(DataInvoice instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'CreatedAt': instance.createdAt.toIso8601String(),
      'UpdatedAt': instance.updatedAt.toIso8601String(),
      'DeletedAt': instance.deletedAt,
      'id': instance.dataId,
      'invoice_name': instance.invoiceName,
      'month': instance.month,
      'amount': instance.amount,
      'purpose': instance.purpose,
      'tenant_id': instance.tenantId,
      'created_at': instance.dataCreatedAt.toIso8601String(),
      'updated_at': instance.dataUpdatedAt.toIso8601String(),
    };
