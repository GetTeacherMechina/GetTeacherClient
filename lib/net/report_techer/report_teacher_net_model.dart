import "package:json_annotation/json_annotation.dart";

part "report_teacher_net_model.g.dart";

@JsonSerializable()
class ReportTeacherNetModel {
  ReportTeacherNetModel({
    required this.report,
    required this.meetingGuid,
  });

  Map<String, dynamic> toJson() => _$ReportTeacherNetModelToJson(this);

  final String report;
  final String meetingGuid;
}
