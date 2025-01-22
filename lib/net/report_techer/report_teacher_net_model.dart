import "package:json_annotation/json_annotation.dart";

part "report_teacher_net_model.g.dart";

@JsonSerializable()
class ReportTeacherNetModel {
  ReportTeacherNetModel({
    required this.report,
  });

  Map<String, dynamic> toJson() => _$ReportTeacherNetModelToJson(this);

  final String report;
}
