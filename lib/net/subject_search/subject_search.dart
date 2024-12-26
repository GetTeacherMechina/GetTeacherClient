import "package:getteacher/net/subject_search/subject_search_net_model.dart";
import "package:getteacher/net/net.dart";

Future<List<SubjectModel>> subjectSearch(final String subjectName) async {
  final Map<String, dynamic> response = await getClient().getJson(
      "/subjects/search", <String, String>{"subjectName": subjectName},);

  final List<SubjectModel> subjects =
      SubjectSearchResponseModel.fromJson(response).subjects;

  return subjects;
}
