import "package:getteacher/net/net.dart";
import "package:getteacher/net/teacher_subjects/teacher_subjects_models.dart";

Future<List<TeacherSubjectsModel>> getTeacherSubjectSelector() async {
  final Map<String, dynamic> json =
      await getClient().getJson("/teacher-subjects");
  final GetTeacherSubjectsResponseModel data =
      GetTeacherSubjectsResponseModel.fromJson(json);
  return data.teacherSubjects;
}

Future<void> addTeacherSubjects(
  final String subject,
  final List<String> grades,
) async {
  await getClient().postJson(
    "/teacher-subjects/add",
    <String, dynamic>{
      "TeacherSubjects": grades
          .map(
            (final String g) => <String, String>{
              "Subject": subject,
              "Grade": g,
            },
          )
          .toList()
    },
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
