import 'package:json_annotation/json_annotation.dart';
import 'package:vidic/models/statement/get_statement_type.dart';

part 'get_statement_data.g.dart';

@JsonSerializable()
class Datum {
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
    this.invoiceTypes,
    this.lettersTypes,
    this.lettersTenantTypes,
    // required this.id,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.deletedAt,
    // required this.datumId,
    // required this.statementName,
    // required this.startDate,
    // required this.endDate,
    // required this.amount,
    // required this.tenantId,
    // required this.datumCreatedAt,
    // required this.datumUpdatedAt,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int datumId;
  String name;
  String number;
  String vidicEmail;
  String officialEmail;
  String about;
  String floor;
  String rent;
  String escalation;
  String pobox;
  DateTime leaseStartDate;
  DateTime leaseEndDate;
  String active;
  String password;
  DateTime datumCreatedAt;
  DateTime datumUpdatedAt;
  List<StatementType> statementTypes;
  dynamic invoiceTypes;
  dynamic lettersTypes;
  dynamic lettersTenantTypes;
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
