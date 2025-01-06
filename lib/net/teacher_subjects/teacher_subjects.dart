import "package:getteacher/net/net.dart";
import "package:getteacher/net/teacher_subjects/teacher_subjects_models.dart";

Future<List<TeacherSubjectModel>> getTeacherSubjectSelector() async {
  final Map<String, dynamic> json =
      await getClient().postJson("/teacher-subjects", <String, dynamic>{});
  final GetTeacherSubjectsResponseModel data =
      GetTeacherSubjectsResponseModel.fromJson(json);
  final List<TeacherSubjectModel> ans = <TeacherSubjectModel>[];
  for (int i = 0; i < data.grades.length; i++) {
    ans.add(
      TeacherSubjectModel(grade: data.grades[i], subject: data.subjects[i]),
    );
  }
  print(ans);
  return ans;
}

Future<void> addTeacherSubject(final String subject, final String grade) async {
  await getClient().postJson(
    "/teacher_subjects/add",
    <String, String>{"Name": subject, "Grade": grade},
  );
}

Future<void> removeTeacherSubject(
    final String subject, final String grade) async {
  await getClient().postJson(
    "/teacher_subjects/remove",
    <String, String>{"Name": subject, "Grade": grade},
  );
}
