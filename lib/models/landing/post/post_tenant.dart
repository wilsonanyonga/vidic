import 'package:vidic/models/landing/post/post_tenant2.dart';

import 'package:json_annotation/json_annotation.dart';

part 'post_tenant.g.dart';

@JsonSerializable()
class PostTenant {
  PostTenant({
    required this.data,
    required this.status,
  });

  DataPostTenant data;
  int status;

  factory PostTenant.fromJson(Map<String, dynamic> json) =>
      _$PostTenantFromJson(json);

  Map<String, dynamic> toJson() => _$PostTenantToJson(this);
}
