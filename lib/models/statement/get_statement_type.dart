// import 'package:vidic/models/statement/get_statement_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_statement_type.g.dart';

@JsonSerializable()
class StatementType {
  StatementType({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.statementTypeId,
    required this.statementName,
    required this.startDate,
    required this.endDate,
    required this.amount,
    required this.tenantId,
    required this.statementTypeCreatedAt,
    required this.statementTypeUpdatedAt,
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
  int statementTypeId;
  @JsonKey(name: 'statement_name')
  String? statementName;
  @JsonKey(name: 'start_date')
  DateTime startDate;
  @JsonKey(name: 'end_date')
  DateTime endDate;
  int amount;
  @JsonKey(name: 'tenant_id')
  int tenantId;
  @JsonKey(name: 'created_at')
  DateTime statementTypeCreatedAt;
  @JsonKey(name: 'updated_at')
  DateTime statementTypeUpdatedAt;

  factory StatementType.fromJson(Map<String, dynamic> json) =>
      _$StatementTypeFromJson(json);

  Map<String, dynamic> toJson() => _$StatementTypeToJson(this);
}
