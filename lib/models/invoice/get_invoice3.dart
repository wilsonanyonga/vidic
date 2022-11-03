import 'package:json_annotation/json_annotation.dart';

part 'get_invoice3.g.dart';

@JsonSerializable()
class InvoiceType {
  InvoiceType({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.invoiceTypeId,
    required this.invoiceName,
    required this.month,
    required this.amount,
    required this.purpose,
    required this.tenantId,
    required this.invoiceTypeCreatedAt,
    required this.invoiceTypeUpdatedAt,
  });

  @JsonKey(name: 'ID')
  int id;
  @JsonKey(name: 'CreatedAt')
  DateTime createdAt;
  @JsonKey(name: 'UpdatedAt')
  DateTime updatedAt;
  @JsonKey(name: 'DeletedAt')
  dynamic deletedAt;
  @JsonKey(name: 'id')
  int invoiceTypeId;
  @JsonKey(name: 'invoice_name')
  String invoiceName;
  String month;
  int amount;
  String purpose;
  @JsonKey(name: 'tenant_id')
  int tenantId;
  @JsonKey(name: 'created_at')
  DateTime invoiceTypeCreatedAt;
  @JsonKey(name: 'updated_at')
  DateTime invoiceTypeUpdatedAt;

  factory InvoiceType.fromJson(Map<String, dynamic> json) =>
      _$InvoiceTypeFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceTypeToJson(this);
}
