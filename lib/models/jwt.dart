import 'package:json_annotation/json_annotation.dart';

part 'jwt.g.dart';

@JsonSerializable()
class Jwt {
  Jwt({
    required this.data,
    required this.status,
  });

  String data;
  int status;

  factory Jwt.fromJson(Map<String, dynamic> json) => _$JwtFromJson(json);

  Map<String, dynamic> toJson() => _$JwtToJson(this);
}
