import 'package:vidic/models/occupancy/get_occupancy2.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_occupancy.g.dart';

@JsonSerializable()
class GetOccupancy {
  GetOccupancy({
    required this.data,
    required this.status,
  });

  List<DatumOccupancy> data;
  int status;

  factory GetOccupancy.fromJson(Map<String, dynamic> json) =>
      _$GetOccupancyFromJson(json);

  Map<String, dynamic> toJson() => _$GetOccupancyToJson(this);
}
