import "package:getteacher/net/net.dart";

Future<void> callTeacher(final String subject) async {
  await getClient().postJson(
    "/meeting/student/start",
    <String, dynamic>{"Name": subject},
  );
}
