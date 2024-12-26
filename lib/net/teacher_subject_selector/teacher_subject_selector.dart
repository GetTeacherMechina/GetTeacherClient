import "package:json_annotation/json_annotation.dart";

part "teacher_subject_selector.g.dart";

@JsonSerializable()
class TeacherSubjectSelectorRequestModel {
  TeacherSubjectSelectorRequestModel({required this.grades, required this.subjects});

  Map<String, dynamic> toJson() => _$TeacherSubjectSelectorRequestModelToJson(this);

  final List<String> grades;
  final List<String> subjects;
}

@JsonSerializable()
class TeacherSubjectSelectorResponseModel {
  const TeacherSubjectSelectorResponseModel({
    required this.grades,
    required this.subjects
  });

  factory TeacherSubjectSelectorResponseModel.fromJson(final Map<String, dynamic> json) => 
      _$TeacherSubjectSelectorResponseModelFromJson(json);

  final List<String> grades;
  final List<String> subjects;
}
