
import "package:getteacher/net/teacher_subject_selector/teacher_subject_selector.dart";

class TeacherSubjectSelctorModel {
  TeacherSubjectSelctorModel()
    : grades = <String>[],
      subjects = <String>[];

  const TeacherSubjectSelctorModel._hidden({
    required this.grades,
    required this.subjects,
  });

  final List<String> grades;
  final List<String> subjects;

  TeacherSubjectSelctorModel copyWith({
    final List<String> Function()? grades,
    final List<String> Function()? subjects,
  }) =>
      TeacherSubjectSelctorModel._hidden(
        grades: grades != null ? grades() : this.grades,
        subjects: subjects != null ? subjects() : this.subjects,
      );

  TeacherSubjectSelectorRequestModel toRequest() =>
      TeacherSubjectSelectorRequestModel(grades: grades, subjects: subjects);
}