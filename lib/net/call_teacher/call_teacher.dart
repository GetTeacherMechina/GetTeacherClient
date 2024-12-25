import "package:getteacher/net/net.dart";

Future<void> callTeacher() async {
  await getClient().postJson("/call-teacher", <String, dynamic>{});
}
