import 'package:vidic/models/landing/tenants2.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tenants.g.dart';

@JsonSerializable()
class GetTenant {
  GetTenant({
    required this.data,
    required this.status,
  });

  List<DatumTenant> data;
  int status;

  factory GetTenant.fromJson(Map<String, dynamic> json) =>
      _$GetTenantFromJson(json);

  Map<String, dynamic> toJson() => _$GetTenantToJson(this);
}
