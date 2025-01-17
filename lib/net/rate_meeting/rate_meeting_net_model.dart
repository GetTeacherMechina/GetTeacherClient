import "package:json_annotation/json_annotation.dart";

part "rate_meeting_net_model.g.dart";

@JsonSerializable()
class RateMeetingRequestModel {
  RateMeetingRequestModel({required this.guid, required this.rating, required this.favoriteTeacher});

  final String guid;

  final int rating;

  final bool favoriteTeacher;

  Map<String, dynamic> toJson() => _$RateMeetingRequestModelToJson(this);
}
