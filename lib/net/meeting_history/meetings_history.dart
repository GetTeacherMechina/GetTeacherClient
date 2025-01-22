import "package:getteacher/net/meeting_history/meeting_history_net_model.dart";
import "package:getteacher/net/net.dart";

Future<MeetingsHistoryNetModel> getMeetingsHistory() async =>
  MeetingsHistoryNetModel.fromJson(await getClient().getJson("/MeetingHistory"));