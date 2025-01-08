import "package:json_annotation/json_annotation.dart";

part "rate_meeting_net_model.g.dart";

@JsonSerializable()
class RateMeetingRequestModel {
  RateMeetingRequestModel({ required this.guid, required this.rating});

  final String guid;
  final int rating;

  Map<String, dynamic> toJson() => _$RateMeetingRequestModelToJson(this);

}