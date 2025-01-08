import "package:json_annotation/json_annotation.dart";

part "meeting_response.g.dart";

@JsonSerializable()
class MeetingResponse {
  MeetingResponse({required this.meetingGuid, required this.companionName});

  factory MeetingResponse.fromJson(final Map<String, dynamic> json) =>
      _$MeetingResponseFromJson(json);

  @JsonKey(name: "MeetingGuid")
  final String meetingGuid;
  @JsonKey(name: "CompanionName")
  final String companionName;
}
