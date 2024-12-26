import "package:json_annotation/json_annotation.dart";

part "call_model.g.dart";

@JsonSerializable()
class CallModel {
  CallModel({required this.meetingId, required this.companionName});

  factory CallModel.fromJson(final Map<String, dynamic> json) =>
      _$CallModelFromJson(json);

  @JsonKey(name: "MeetingId")
  final int meetingId;
  @JsonKey(name: "CompanionName")
  final String companionName;
}
