import 'package:vidic/models/letter/get_letter2.dart';

import 'package:json_annotation/json_annotation.dart';

part 'get_letter.g.dart';

@JsonSerializable()
class GetLetter {
  GetLetter({
    required this.data,
    required this.status,
  });

  List<DatumLetter> data;
  int status;

  factory GetLetter.fromJson(Map<String, dynamic> json) =>
      _$GetLetterFromJson(json);

  Map<String, dynamic> toJson() => _$GetLetterToJson(this);
}
