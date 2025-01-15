import "package:getteacher/net/net.dart";
import "package:getteacher/net/reset_password/reset_password_net_model.dart";


Future<void> resetPassword(final ResetPasswordResponsModle model) async {
  await getClient().postJson("/reset-password/reset-password", model.toJson());
}
