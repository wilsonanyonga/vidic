import 'package:json_annotation/json_annotation.dart';

part 'get_occupancy2.g.dart';

@JsonSerializable()
class DatumOccupancy {
  DatumOccupancy({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.datumId,
    required this.floor,
    required this.occupancy,
    required this.capacity,
    required this.datumCreatedAt,
    required this.datumUpdatedAt,
  });

  @JsonKey(name: 'ID')
  int id;
  @JsonKey(name: 'CreatedAt')
  DateTime createdAt;
  @JsonKey(name: 'UpdatedAt')
  DateTime updatedAt;
  @JsonKey(name: 'DeletedAt')
  dynamic deletedAt;
  @JsonKey(name: 'id')
  int datumId;
  int floor;
  int occupancy;
  int capacity;
  @JsonKey(name: 'created_at')
  DateTime datumCreatedAt;
  @JsonKey(name: 'updated_at')
  DateTime datumUpdatedAt;

  factory DatumOccupancy.fromJson(Map<String, dynamic> json) =>
      _$DatumOccupancyFromJson(json);

  Map<String, dynamic> toJson() => _$DatumOccupancyToJson(this);
}
