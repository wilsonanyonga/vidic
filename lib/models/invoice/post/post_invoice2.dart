import 'package:json_annotation/json_annotation.dart';

part 'post_invoice2.g.dart';

@JsonSerializable()
class DataInvoice {
  DataInvoice({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.dataId,
    required this.invoiceName,
    required this.month,
    required this.amount,
    required this.purpose,
    required this.tenantId,
    required this.dataCreatedAt,
    required this.dataUpdatedAt,
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
  int dataId;
  @JsonKey(name: 'invoice_name')
  String invoiceName;
  String month;
  int amount;
  String purpose;
  @JsonKey(name: 'tenant_id')
  int tenantId;
  @JsonKey(name: 'created_at')
  DateTime dataCreatedAt;
  @JsonKey(name: 'updated_at')
  DateTime dataUpdatedAt;

  factory DataInvoice.fromJson(Map<String, dynamic> json) =>
      _$DataInvoiceFromJson(json);

  Map<String, dynamic> toJson() => _$DataInvoiceToJson(this);
}
