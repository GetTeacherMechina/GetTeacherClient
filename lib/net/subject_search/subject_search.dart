import 'package:getteacher/net/subject_search/subject_search_net_model.dart';
import 'package:getteacher/net/net.dart';

Future<List<SubjectModel>> subjectSearch(final SubjectSearchRequestModel request) async
{
  final Map<String, dynamic> response =
    await getClient().postJson("/subjects/search", request.toJson());
  
  final List<SubjectModel> subjects = SubjectSearchResponseModel.fromJson(response).subjects;

  return subjects;

}