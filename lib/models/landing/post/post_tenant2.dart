import 'package:json_annotation/json_annotation.dart';

part 'post_tenant2.g.dart';

@JsonSerializable()
class DataPostTenant {
  DataPostTenant({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.dataId,
    required this.name,
    required this.number,
    required this.vidicEmail,
    required this.officialEmail,
    required this.about,
    required this.floor,
    required this.size,
    required this.rent,
    required this.escalation,
    required this.pobox,
    required this.leaseStartDate,
    required this.leaseEndDate,
    required this.active,
    required this.password,
    required this.dataCreatedAt,
    required this.dataUpdatedAt,
    required this.statementTypes,
    required this.invoiceTypes,
    required this.lettersTypes,
    required this.lettersTenantTypes,
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
  String name;
  String number;
  @JsonKey(name: 'vidic_email')
  String vidicEmail;
  @JsonKey(name: 'official_email')
  String officialEmail;
  String about;
  String floor;
  String size;
  String rent;
  String escalation;
  String pobox;
  @JsonKey(name: 'lease_start_date')
  DateTime leaseStartDate;
  @JsonKey(name: 'lease_end_date')
  DateTime leaseEndDate;
  String active;
  String password;
  @JsonKey(name: 'created_at')
  DateTime dataCreatedAt;
  @JsonKey(name: 'updated_at')
  DateTime dataUpdatedAt;
  @JsonKey(name: 'StatementTypes')
  dynamic statementTypes;
  @JsonKey(name: 'InvoiceTypes')
  dynamic invoiceTypes;
  @JsonKey(name: 'LettersTypes')
  dynamic lettersTypes;
  @JsonKey(name: 'LettersTenantTypes')
  dynamic lettersTenantTypes;

  factory DataPostTenant.fromJson(Map<String, dynamic> json) =>
      _$DataPostTenantFromJson(json);

  Map<String, dynamic> toJson() => _$DataPostTenantToJson(this);
}
