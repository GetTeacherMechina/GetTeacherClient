import "package:getteacher/net/meeting_history/meeting_history_net_model.dart";
import "package:getteacher/net/net.dart";

Future<MeetingsHistoryNetModelRequst> getMeetingsHistory(
        final MeetingsHistoryNetModelRespons response,) async =>
    MeetingsHistoryNetModelRequst.fromJson(
      await getClient().postJson("/MeetingsHistory", response.toJson()),
    );
