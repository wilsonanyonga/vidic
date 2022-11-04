import 'package:json_annotation/json_annotation.dart';

part 'get_tenant_letter3.g.dart';

@JsonSerializable()
class LettersTenantType {
  LettersTenantType({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.lettersTenantTypeId,
    required this.letterName,
    required this.tenantId,
    required this.subject,
    required this.date,
    required this.lettersTenantTypeCreatedAt,
    required this.lettersTenantTypeUpdatedAt,
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
  int lettersTenantTypeId;
  @JsonKey(name: 'letter_name')
  String letterName;
  @JsonKey(name: 'tenant_id')
  int tenantId;
  String subject;
  DateTime date;
  @JsonKey(name: 'created_at')
  DateTime lettersTenantTypeCreatedAt;
  @JsonKey(name: 'updated_at')
  DateTime lettersTenantTypeUpdatedAt;

  factory LettersTenantType.fromJson(Map<String, dynamic> json) =>
      _$LettersTenantTypeFromJson(json);

  Map<String, dynamic> toJson() => _$LettersTenantTypeToJson(this);
}
