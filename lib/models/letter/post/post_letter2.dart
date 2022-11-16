import 'package:json_annotation/json_annotation.dart';

part 'post_letter2.g.dart';

@JsonSerializable()
class DataLetter {
  DataLetter({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.dataId,
    required this.letterName,
    required this.tenantId,
    required this.subject,
    required this.date,
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
  @JsonKey(name: 'letter_name')
  String letterName;
  @JsonKey(name: 'tenant_id')
  int tenantId;
  String subject;
  DateTime date;
  @JsonKey(name: 'created_at')
  DateTime dataCreatedAt;
  @JsonKey(name: 'updated_at')
  DateTime dataUpdatedAt;

  factory DataLetter.fromJson(Map<String, dynamic> json) =>
      _$DataLetterFromJson(json);

  Map<String, dynamic> toJson() => _$DataLetterToJson(this);
}
