import 'package:json_annotation/json_annotation.dart';
import 'package:vidic/models/letter/post/post_letter2.dart';

part 'post_letter.g.dart';

@JsonSerializable()
class PostLetter {
  PostLetter({
    required this.data,
    required this.filename,
    required this.message,
    required this.status,
  });

  DataLetter data;
  String filename;
  String message;
  int status;

  factory PostLetter.fromJson(Map<String, dynamic> json) =>
      _$PostLetterFromJson(json);

  Map<String, dynamic> toJson() => _$PostLetterToJson(this);
}
