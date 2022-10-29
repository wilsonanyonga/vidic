import 'package:json_annotation/json_annotation.dart';
import 'package:vidic/models/statement/get_statement_type.dart';

part 'get_statement_data.g.dart';

@JsonSerializable()
class Datum {
  @JsonKey(name: 'ID')
  int id;
  @JsonKey(name: 'CreatedAt')
  DateTime createdAt;
  @JsonKey(name: 'UpdatedAt')
  DateTime updatedAt;
  @JsonKey(name: 'DeletedAt')
  DateTime? deletedAt;
  @JsonKey(name: 'id')
  int datumId;
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
  DateTime datumCreatedAt;
  @JsonKey(name: 'updated_at')
  DateTime datumUpdatedAt;
  @JsonKey(name: 'StatementTypes')
  List<StatementType> statementTypes;
  @JsonKey(name: 'InvoiceTypes')
  dynamic invoiceTypes;
  @JsonKey(name: 'LettersTypes')
  dynamic lettersTypes;
  @JsonKey(name: 'LettersTenantTypes')
  dynamic lettersTenantTypes;

  Datum({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.datumId,
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
    required this.datumCreatedAt,
    required this.datumUpdatedAt,
    required this.statementTypes,
    required this.invoiceTypes,
    required this.lettersTypes,
    required this.lettersTenantTypes,
    // this.id,
    // this.createdAt,
    // this.updatedAt,
    // this.deletedAt,
    // this.datumId,
    // this.statementName,
    // this.startDate,
    // this.endDate,
    // this.amount,
    // this.tenantId,
    // this.datumCreatedAt,
    // this.datumUpdatedAt,
  });

  // @JsonKey(name: 'ID')
  // int id;
  // @JsonKey(name: 'CreatedAt')
  // DateTime createdAt;
  // @JsonKey(name: 'UpdatedAt')
  // DateTime updatedAt;
  // @JsonKey(name: 'DeletedAt')
  // dynamic deletedAt;
  // @JsonKey(name: 'id')
  // int datumId;
  // @JsonKey(name: 'statement_name')
  // String statementName;
  // @JsonKey(name: 'start_date')
  // DateTime startDate;
  // @JsonKey(name: 'end_date')
  // DateTime endDate;
  // int amount;
  // @JsonKey(name: 'tenant_id')
  // int tenantId;
  // @JsonKey(name: 'created_at')
  // DateTime datumCreatedAt;
  // @JsonKey(name: 'updated_at')
  // DateTime datumUpdatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
