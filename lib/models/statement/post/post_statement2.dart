import 'package:json_annotation/json_annotation.dart';

part 'post_statement2.g.dart';

@JsonSerializable()
class DataStatement {
  DataStatement({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.dataId,
    required this.statementName,
    required this.startDate,
    required this.endDate,
    required this.amount,
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
  @JsonKey(name: 'statement_name')
  String statementName;
  @JsonKey(name: 'start_date')
  DateTime startDate;
  @JsonKey(name: 'end_date')
  DateTime endDate;
  int amount;
  @JsonKey(name: 'tenant_id')
  int tenantId;
  @JsonKey(name: 'created_at')
  DateTime dataCreatedAt;
  @JsonKey(name: 'updated_at')
  DateTime dataUpdatedAt;
  factory DataStatement.fromJson(Map<String, dynamic> json) =>
      _$DataStatementFromJson(json);

  Map<String, dynamic> toJson() => _$DataStatementToJson(this);
}
