import "package:getteacher/net/net.dart";

Future<void> startMettingSearching() async {
  await getClient().postJson(
    "/meeting/teacher/start",
    <String, dynamic>{
      "Subject": <String, String>{
        "Name": "Math",
      },
      "Grade": <String, String>{"Name": "יב"},
    },
  );
}

Future<void> stopMettingSearching() async {
  await getClient().postJson("/meeting/teacher/stop", <String, dynamic>{});
}
