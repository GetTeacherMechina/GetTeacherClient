import "package:getteacher/net/subject_search/subject_search_net_model.dart";
import "package:getteacher/net/net.dart";

Future<List<String>> subjectSearch() async {
  final Map<String, dynamic> response = await getClient().getJson(
    "/subjects/",
  );

  final SubjectSearchResponseModel subjects =
      SubjectSearchResponseModel.fromJson(response);

  return subjects.subjects;
}
