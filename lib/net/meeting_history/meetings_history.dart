import "package:getteacher/net/meeting_history/meeting_history_net_model.dart";
import "package:getteacher/net/net.dart";

Future<MeetingsHistoryResponse> getMeetingsHistory(
  final MeetingsHistoryRequest response,
) async =>
    MeetingsHistoryResponse.fromJson(
      await getClient().postJson("/MeetingsHistory", response.toJson()),
    );
