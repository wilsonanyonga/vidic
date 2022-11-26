import 'package:json_annotation/json_annotation.dart';
import 'package:vidic/models/jwt2.dart';

part 'jwt.g.dart';

@JsonSerializable()
class Jwt {
  Jwt({
    required this.data,
    required this.status,
    required this.user,
  });

  String data;
  int status;
  List<UserJWT> user;

  factory Jwt.fromJson(Map<String, dynamic> json) => _$JwtFromJson(json);

  Map<String, dynamic> toJson() => _$JwtToJson(this);
}
