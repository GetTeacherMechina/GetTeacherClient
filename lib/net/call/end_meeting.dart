import "package:getteacher/net/net.dart";
import "package:json_annotation/json_annotation.dart";

part "end_meeting.g.dart";

Future<void> endMeetingRequest(
    final EndMeetingRequestModel endMeetingRequestModel) async {
  await getClient().postJson("/meeting/end", endMeetingRequestModel.toJson());
}

@JsonSerializable()
class EndMeetingRequestModel {
  EndMeetingRequestModel({required this.meetingGuid});

  Map<String, dynamic> toJson() => _$EndMeetingRequestModelToJson(this);

  @JsonKey(name: "MeetingGuid")
  final String meetingGuid;
}
