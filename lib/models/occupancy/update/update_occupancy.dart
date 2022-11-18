import 'package:json_annotation/json_annotation.dart';
import 'package:vidic/models/occupancy/update/update_occupancy2.dart';

part 'update_occupancy.g.dart';

@JsonSerializable()
class UpdateOccupancy {
  UpdateOccupancy({
    required this.data,
    required this.status,
  });

  DataOccupancyUpdate data;
  int status;
  factory UpdateOccupancy.fromJson(Map<String, dynamic> json) =>
      _$UpdateOccupancyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateOccupancyToJson(this);
}
