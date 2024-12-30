import "package:getteacher/net/net.dart";
import "package:getteacher/net/teacher_subject_selector/teacher_subject_selector.dart";

Future<List<TeacherSubjectModel>> getTeacherSubjectSelector() async {
  final Map<String, dynamic> json =
      await getClient().getJson("/TeacherSubjectSelectorController");
  final TeacherSubjectSelectorResponseModel data =
      TeacherSubjectSelectorResponseModel.fromJson(json);
  final List<TeacherSubjectModel> ans = <TeacherSubjectModel>[];
  for (int i = 0; i < data.grades.length; i++) {
    ans.add(TeacherSubjectModel(grade: data.grades[i], subject: data.subjects[i]));
  }
  return ans;
}
