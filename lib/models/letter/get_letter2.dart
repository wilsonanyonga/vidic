import 'package:vidic/models/letter/get_letter3.dart';

import 'package:json_annotation/json_annotation.dart';

part 'get_letter2.g.dart';

@JsonSerializable()
class DatumLetter {
  DatumLetter({
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
  dynamic statementTypes;
  @JsonKey(name: 'InvoiceTypes')
  dynamic invoiceTypes;
  @JsonKey(name: 'LettersTypes')
  List<LettersType> lettersTypes;
  @JsonKey(name: 'LettersTenantTypes')
  dynamic lettersTenantTypes;

  factory DatumLetter.fromJson(Map<String, dynamic> json) =>
      _$DatumLetterFromJson(json);

  Map<String, dynamic> toJson() => _$DatumLetterToJson(this);
}
