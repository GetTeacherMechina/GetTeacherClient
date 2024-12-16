import "package:getteacher/net/net.dart";
import "package:getteacher/net/register/register_net_model.dart";

Future<void> register(final RegisterRequestModel request) async {
  await getClient().postJson("/auth/register", request.toJson());
}
