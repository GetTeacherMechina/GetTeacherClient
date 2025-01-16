import "package:getteacher/net/net.dart";

Future<void> startMeetingSearching() async {
  await getClient().postJson("/meeting/teacher/start", <String, dynamic>{});
}

Future<void> stopMeetingSearching() async {
  await getClient().postJson("/meeting/teacher/stop", <String, dynamic>{});
}
