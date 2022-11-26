// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jwt2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserJWT _$UserJWTFromJson(Map<String, dynamic> json) => UserJWT(
      id: json['ID'] as int,
      createdAt: DateTime.parse(json['CreatedAt'] as String),
      updatedAt: DateTime.parse(json['UpdatedAt'] as String),
      deletedAt: json['DeletedAt'],
      userId: json['id'] as int,
      name: json['name'] as String,
      number: json['number'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      picture: json['picture'] as String,
      active: json['active'] as String,
      password: json['password'] as String,
      userCreatedAt: DateTime.parse(json['created_at'] as String),
      userUpdatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$UserJWTToJson(UserJWT instance) => <String, dynamic>{
      'ID': instance.id,
      'CreatedAt': instance.createdAt.toIso8601String(),
      'UpdatedAt': instance.updatedAt.toIso8601String(),
      'DeletedAt': instance.deletedAt,
      'id': instance.userId,
      'name': instance.name,
      'number': instance.number,
      'email': instance.email,
      'role': instance.role,
      'picture': instance.picture,
      'active': instance.active,
      'password': instance.password,
      'created_at': instance.userCreatedAt.toIso8601String(),
      'updated_at': instance.userUpdatedAt.toIso8601String(),
    };
