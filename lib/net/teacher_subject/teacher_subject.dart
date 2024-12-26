import "package:getteacher/net/net.dart";
import "package:getteacher/net/teacher_subject/teacher_subject_model.dart";

Future<List<TeacherSubjectModel>> getTeacherSubjects() async {
  final Map<String, dynamic> response = await getClient().getJson(
    "/teacher_subjects",
  );

  final List<TeacherSubjectModel> subjects =
      TeacherSubjectSearchResponseModel.fromJson(response).subjects;

  return subjects;
}
