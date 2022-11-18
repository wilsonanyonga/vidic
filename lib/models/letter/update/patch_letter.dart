// import 'package:json_annotation/json_annotation.dart';

// part 'patch_letter.g.dart';

// @JsonSerializable()
// class PatchLetter {
//     PatchLetter({
//         required this.data,
//         required this.status,
//     });

//     DataPatchLetter data;
//     int status;

//     factory PatchLetter.fromJson(Map<String, dynamic> json) =>
//       _$PatchLetterFromJson(json);

//   Map<String, dynamic> toJson() => _$PatchLetterToJson(this);
// }

// import 'package:json_annotation/json_annotation.dart';

// part 'patch_letter2.g.dart';

// @JsonSerializable()
// class DataPatchLetter {
//     DataPatchLetter({
//         required this.id,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.deletedAt,
//         required this.dataId,
//         required this.letterName,
//         required this.tenantId,
//         required this.subject,
//         required this.date,
//         required this.dataCreatedAt,
//         required this.dataUpdatedAt,
//     });

//     @JsonKey(name: 'ID')
//   int id;
//   @JsonKey(name: 'CreatedAt')
//   DateTime createdAt;
//   @JsonKey(name: 'UpdatedAt')
//   DateTime updatedAt;
//   @JsonKey(name: 'DeletedAt')
//   dynamic deletedAt;
//   @JsonKey(name: 'id')
//     int dataId;
//     String letterName;
//     int tenantId;
//     String subject;
//     DateTime date;
//     DateTime dataCreatedAt;
//     DateTime dataUpdatedAt;

//     factory DataPatchLetter.fromJson(Map<String, dynamic> json) =>
//       _$DataPatchLetterFromJson(json);

//   Map<String, dynamic> toJson() => _$DataPatchLetterToJson(this);
// }
