import "package:getteacher/net/net.dart";

Future<void> startSearchingForTeacher(final String subject) async {
  await getClient().postJson(
    "/meeting/student/start",
    <String, dynamic>{"Name": subject},
  );
}

Future<void> stopSearchingForTeacher() async {
  await getClient().postJson("/meeting/student/stop", <String, dynamic>{});
}
