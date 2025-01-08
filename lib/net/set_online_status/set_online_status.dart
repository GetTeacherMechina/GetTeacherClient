import "package:getteacher/net/net.dart";

Future<void> startMettingSearching(
    final String subjectName, final String gradeName) async {
  await getClient().postJson(
    "/meeting/teacher/start",
    <String, dynamic>{
      "Subject": <String, String>{
        "Name": subjectName,
      },
      "Grade": <String, String>{"Name": gradeName},
    },
  );
}

Future<void> stopMettingSearching() async {
  await getClient().postJson("/meeting/teacher/stop", <String, dynamic>{});
}
