import 'package:json_annotation/json_annotation.dart';

part 'delete_letter.g.dart';

@JsonSerializable()
class DeleteLetter {
  DeleteLetter({
    required this.data,
    required this.status,
  });

  bool data;
  int status;

  factory DeleteLetter.fromJson(Map<String, dynamic> json) =>
      _$DeleteLetterFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteLetterToJson(this);
}
