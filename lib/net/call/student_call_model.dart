import "package:getteacher/net/call/meeting_response.dart";
import "package:json_annotation/json_annotation.dart";

part "student_call_model.g.dart";

@JsonSerializable()
class StudentCallModel {
  StudentCallModel(
    this.teacherBio,
    this.teacherRank,
    this.meetingResponse,
  );

  factory StudentCallModel.fromJson(final Map<String, dynamic> json) =>
      _$StudentCallModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudentCallModelToJson(this);

  @JsonKey(name: "TeacherBio")
  final String teacherBio;

  @JsonKey(name: "TeacherRank")
  final double teacherRank;

  @JsonKey(name: "MeetingResponseModel")
  final MeetingResponse meetingResponse;
}
