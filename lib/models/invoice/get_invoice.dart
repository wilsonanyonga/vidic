import 'package:vidic/models/invoice/get_invoice2.dart';

import 'package:json_annotation/json_annotation.dart';

part 'get_invoice.g.dart';

@JsonSerializable()
class GetInvoice {
  GetInvoice({
    required this.data,
    required this.status,
  });

  List<DatumInvoice> data;
  int status;

  factory GetInvoice.fromJson(Map<String, dynamic> json) =>
      _$GetInvoiceFromJson(json);

  Map<String, dynamic> toJson() => _$GetInvoiceToJson(this);
}
