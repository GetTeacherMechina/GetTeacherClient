import "package:getteacher/net/net.dart";

Future<void> validate() async {
  await getClient().getJson("/validate");
}
