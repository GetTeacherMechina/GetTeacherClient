import 'package:json_annotation/json_annotation.dart';

part 'teacher_subject_model.g.dart';

@JsonSerializable()
class TeacherSubjectModel {
  TeacherSubjectModel({
    required this.id,
    required this.subject,
    required this.grade,
  });

  factory TeacherSubjectModel.fromJson(final Map<String, dynamic> json) =>
      _$TeacherSubjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherSubjectModelToJson(this);

  final int id;
  final String subject;
  final String grade;
}
@JsonSerializable()
class TeacherSubjectSearchResponseModel {
  TeacherSubjectSearchResponseModel({required this.subjects});
  factory TeacherSubjectSearchResponseModel.fromJson(
          final Map<String, dynamic> json,) =>
      _$TeacherSubjectSearchResponseModelFromJson(json);

  final List<TeacherSubjectModel> subjects;
}