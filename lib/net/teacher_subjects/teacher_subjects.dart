import "package:getteacher/net/net.dart";
import "package:getteacher/net/teacher_subjects/teacher_subjects_models.dart";

Future<List<TeacherSubjectsModel>> getTeacherSubjectSelector() async {
  final Map<String, dynamic> json =
      await getClient().getJson("/teacher-subjects");
  final GetTeacherSubjectsResponseModel data =
      GetTeacherSubjectsResponseModel.fromJson(json);
  return data.teacherSubjects;
}

Future<void> addTeacherSubject(final String subject, final String grade) async {
  await getClient().postJson(
    "/teacher-subjects/add",
    <String, String>{"Subject": subject, "Grade": grade},
  );
}

Future<void> removeTeacherSubject(
  final String subject,
  final String grade,
) async {
  await getClient().postJson(
    "/teacher-subjects/remove",
    <String, String>{"Subject": subject, "Grade": grade},
  );
}
