// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_invoice3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceType _$InvoiceTypeFromJson(Map<String, dynamic> json) => InvoiceType(
      id: json['ID'] as int,
      createdAt: DateTime.parse(json['CreatedAt'] as String),
      updatedAt: DateTime.parse(json['UpdatedAt'] as String),
      deletedAt: json['DeletedAt'],
      invoiceTypeId: json['id'] as int,
      invoiceName: json['invoice_name'] as String,
      month: json['month'] as String,
      amount: json['amount'] as int,
      purpose: json['purpose'] as String,
      tenantId: json['tenant_id'] as int,
      invoiceTypeCreatedAt: DateTime.parse(json['created_at'] as String),
      invoiceTypeUpdatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$InvoiceTypeToJson(InvoiceType instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'CreatedAt': instance.createdAt.toIso8601String(),
      'UpdatedAt': instance.updatedAt.toIso8601String(),
      'DeletedAt': instance.deletedAt,
      'id': instance.invoiceTypeId,
      'invoice_name': instance.invoiceName,
      'month': instance.month,
      'amount': instance.amount,
      'purpose': instance.purpose,
      'tenant_id': instance.tenantId,
      'created_at': instance.invoiceTypeCreatedAt.toIso8601String(),
      'updated_at': instance.invoiceTypeUpdatedAt.toIso8601String(),
    };
