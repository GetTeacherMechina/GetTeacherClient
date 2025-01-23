import "package:json_annotation/json_annotation.dart";

part "report_teacher_net_model.g.dart";

@JsonSerializable()
class ReportTeacherRequest {
  ReportTeacherRequest({
    required this.reportContent,
    required this.meetingGuid,
  });

  Map<String, dynamic> toJson() => _$ReportTeacherRequestToJson(this);

  final String reportContent;
  final String meetingGuid;
}
