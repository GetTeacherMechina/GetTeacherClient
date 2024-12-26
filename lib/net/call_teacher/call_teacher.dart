import "package:getteacher/net/net.dart";

Future<void> callTeacher() async {
  await getClient().postJson(
    "/meeting/student/start",
    <String, dynamic>{"Name": "computer-science"},
  );
}
