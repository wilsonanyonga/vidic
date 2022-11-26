// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jwt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Jwt _$JwtFromJson(Map<String, dynamic> json) => Jwt(
      data: json['data'] as String,
      status: json['status'] as int,
      user: (json['user'] as List<dynamic>)
          .map((e) => UserJWT.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JwtToJson(Jwt instance) => <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'user': instance.user,
    };
