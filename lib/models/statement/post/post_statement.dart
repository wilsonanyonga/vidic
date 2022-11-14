import 'package:vidic/models/statement/post/post_statement2.dart';

import 'package:json_annotation/json_annotation.dart';

part 'post_statement.g.dart';

@JsonSerializable()
class PostStatement {
  PostStatement({
    required this.data,
    required this.filename,
    required this.message,
    required this.status,
  });

  DataStatement data;
  String filename;
  String message;
  int status;
  factory PostStatement.fromJson(Map<String, dynamic> json) =>
      _$PostStatementFromJson(json);

  Map<String, dynamic> toJson() => _$PostStatementToJson(this);
}
