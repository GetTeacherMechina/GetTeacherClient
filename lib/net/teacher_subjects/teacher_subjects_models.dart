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
    required this.teacherSubjects,
  });

  factory GetTeacherSubjectsResponseModel.fromJson(
    final Map<String, dynamic> json,
  ) =>
      _$GetTeacherSubjectsResponseModelFromJson(json);

  final List<TeacherSubjectsModel> teacherSubjects;
}

@JsonSerializable()
class Subject {
  Subject({required this.name});

  factory Subject.fromJson(final Map<String, dynamic> json) =>
      _$SubjectFromJson(json);

  final String name;
}

@JsonSerializable()
class Grade {
  Grade({required this.name});

  factory Grade.fromJson(final Map<String, dynamic> json) =>
      _$GradeFromJson(json);

  final String name;
}

@JsonSerializable()
class TeacherSubjectsModel {
  TeacherSubjectsModel({required this.grade, required this.subject});

  factory TeacherSubjectsModel.fromJson(final Map<String, dynamic> json) =>
      _$TeacherSubjectsModelFromJson(json);

  final Grade grade;
  final Subject subject;

  @override
  String toString() => "subject: ${subject.name}, grade: ${grade.name}";
}
