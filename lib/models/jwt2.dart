import 'package:json_annotation/json_annotation.dart';

part 'jwt2.g.dart';

@JsonSerializable()
class UserJWT {
  UserJWT({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.userId,
    required this.name,
    required this.number,
    required this.email,
    required this.role,
    required this.picture,
    required this.active,
    required this.password,
    required this.userCreatedAt,
    required this.userUpdatedAt,
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
  int userId;
  String name;
  String number;
  String email;
  String role;
  String picture;
  String active;
  String password;
  @JsonKey(name: 'created_at')
  DateTime userCreatedAt;
  @JsonKey(name: 'updated_at')
  DateTime userUpdatedAt;

  factory UserJWT.fromJson(Map<String, dynamic> json) =>
      _$UserJWTFromJson(json);

  Map<String, dynamic> toJson() => _$UserJWTToJson(this);
}
