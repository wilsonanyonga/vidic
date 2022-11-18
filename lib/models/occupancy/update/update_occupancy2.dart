import 'package:json_annotation/json_annotation.dart';

part 'update_occupancy2.g.dart';

@JsonSerializable()
class DataOccupancyUpdate {
  DataOccupancyUpdate({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.dataId,
    required this.floor,
    required this.occupancy,
    required this.capacity,
    required this.dataCreatedAt,
    required this.dataUpdatedAt,
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
  int dataId;
  int floor;
  int occupancy;
  int capacity;
  @JsonKey(name: 'created_at')
  DateTime dataCreatedAt;
  @JsonKey(name: 'updated_at')
  DateTime dataUpdatedAt;

  factory DataOccupancyUpdate.fromJson(Map<String, dynamic> json) =>
      _$DataOccupancyUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$DataOccupancyUpdateToJson(this);
}
