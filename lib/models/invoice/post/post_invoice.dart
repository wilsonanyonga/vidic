import 'package:json_annotation/json_annotation.dart';
import 'package:vidic/models/invoice/post/post_invoice2.dart';

part 'post_invoice.g.dart';

@JsonSerializable()
class PostInvoice {
  PostInvoice({
    required this.data,
    required this.filename,
    required this.message,
    required this.status,
  });

  DataInvoice data;
  String filename;
  String message;
  int status;
  factory PostInvoice.fromJson(Map<String, dynamic> json) =>
      _$PostInvoiceFromJson(json);

  Map<String, dynamic> toJson() => _$PostInvoiceToJson(this);
}
