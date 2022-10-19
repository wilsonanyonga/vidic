import 'package:vidic/models/statement/get_statement_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_statement.g.dart';

@JsonSerializable()
class GetStatement {
  GetStatement({
    required this.data,
    required this.status,
  });

  List<Datum> data;
  int status;

  factory GetStatement.fromJson(Map<String, dynamic> json) =>
      _$GetStatementFromJson(json);

  Map<String, dynamic> toJson() => _$GetStatementToJson(this);
}
