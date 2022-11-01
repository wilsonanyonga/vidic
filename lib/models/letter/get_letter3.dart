import 'package:json_annotation/json_annotation.dart';

part 'get_letter3.g.dart';

@JsonSerializable()
class LettersType {
  LettersType({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.lettersTypeId,
    required this.letterName,
    required this.tenantId,
    required this.subject,
    required this.date,
    required this.lettersTypeCreatedAt,
    required this.lettersTypeUpdatedAt,
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
  int lettersTypeId;
  @JsonKey(name: 'letter_name')
  String letterName;
  @JsonKey(name: 'tenant_id')
  int tenantId;
  String subject;
  DateTime date;
  @JsonKey(name: 'created_at')
  DateTime lettersTypeCreatedAt;
  @JsonKey(name: 'updated_at')
  DateTime lettersTypeUpdatedAt;

  factory LettersType.fromJson(Map<String, dynamic> json) =>
      _$LettersTypeFromJson(json);

  Map<String, dynamic> toJson() => _$LettersTypeToJson(this);
}
