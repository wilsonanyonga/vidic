import 'package:vidic/models/tenant_letter/get_tenant_letter2.dart';

import 'package:json_annotation/json_annotation.dart';

part 'get_tenant_letter.g.dart';

@JsonSerializable()
class GetTenantLetter {
  GetTenantLetter({
    required this.data,
    required this.status,
  });

  List<DatumTenantLetter> data;
  int status;

  factory GetTenantLetter.fromJson(Map<String, dynamic> json) =>
      _$GetTenantLetterFromJson(json);

  Map<String, dynamic> toJson() => _$GetTenantLetterToJson(this);
}
