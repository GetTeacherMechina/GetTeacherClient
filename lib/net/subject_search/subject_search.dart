import "package:getteacher/net/subject_search/subject_search_net_model.dart";
import "package:getteacher/net/net.dart";

Future<List<String>> subjectSearch() async {
  final Map<String, dynamic> response = await getClient().getJson(
    "/subjects/search",
  );

  final List<String> subjects =
      SubjectSearchResponseModel.fromJson(response).subjects;

  return subjects;
}
