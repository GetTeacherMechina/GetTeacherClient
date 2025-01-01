import "package:getteacher/net/net.dart";
import "package:getteacher/net/teacher_subjects/teacher_subjects_models.dart";

Future<List<TeacherSubjectModel>> getTeacherSubjectSelector() async {
  final Map<String, dynamic> json =
      await getClient().getJson("/TeacherSubjectSelectorController");
  final GetTeacherSubjectsResponseModel data =
      GetTeacherSubjectsResponseModel.fromJson(json);
  final List<TeacherSubjectModel> ans = <TeacherSubjectModel>[];
  for (int i = 0; i < data.grades.length; i++) {
    ans.add(
      TeacherSubjectModel(grade: data.grades[i], subject: data.subjects[i]),
    );
  }
  return ans;
}

Future<void> addTeacherSubject(final String subject, final String grade) async {
  await getClient().postJson(
    "/api/v1/teacher_subjects/add",
    <String, String>{"Subject": subject, "Grade": grade},
  );
}
