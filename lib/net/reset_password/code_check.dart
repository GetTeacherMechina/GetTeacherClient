import "package:getteacher/net/net.dart";
import "package:getteacher/net/reset_password/code_check_net_model.dart";

Future<void> checkCode(final ResetPasswordCodeRequstModel model) async {
  await getClient().postJson("/reset-password/code-check", model.toJson());
}