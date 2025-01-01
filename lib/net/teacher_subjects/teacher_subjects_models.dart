import "package:json_annotation/json_annotation.dart";

part "teacher_subjects_models.g.dart";

@JsonSerializable()
class GetTeacherSubjectsRequestModel {
  GetTeacherSubjectsRequestModel({
    required this.grades,
    required this.subjects,
  });

  Map<String, dynamic> toJson() => _$GetTeacherSubjectsRequestModelToJson(this);

  final List<String> grades;
  final List<String> subjects;
}

@JsonSerializable()
class GetTeacherSubjectsResponseModel {
  const GetTeacherSubjectsResponseModel({
    required this.grades,
    required this.subjects,
  });

  factory GetTeacherSubjectsResponseModel.fromJson(
    final Map<String, dynamic> json,
  ) =>
      _$GetTeacherSubjectsResponseModelFromJson(json);

  final List<String> grades;
  final List<String> subjects;
}

class TeacherSubjectModel {
  TeacherSubjectModel({required this.grade, required this.subject});

  final String grade;
  final String subject;
}
