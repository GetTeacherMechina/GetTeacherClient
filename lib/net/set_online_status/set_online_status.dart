import "package:getteacher/net/net.dart";

Future<void> startMettingSearching() async {
  await getClient().postJson(
    "/meeting/teacher/start",
    <String, dynamic>{
      "Subject": <String, String>{
        "Name": "computer-science",
      },
      "Grade": <String, String>{"Name": "יב"},
    },
  );
}

Future<void> stopMettingSearching() async {
  await getClient().postJson("/meeting/teacher/stop", <String, dynamic>{});
}
