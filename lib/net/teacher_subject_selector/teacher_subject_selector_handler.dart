
import "package:getteacher/net/net.dart";
import "package:getteacher/net/teacher_subject_selector/teacher_subject_selector.dart";

Future<TeacherSubjectSelectorResponseModel> getTeacherSubjectSelector() async {
  final Map<String, dynamic> json = await getClient().getJson("/TeacherSubjectSelectorController");
  return TeacherSubjectSelectorResponseModel.fromJson(json);
}