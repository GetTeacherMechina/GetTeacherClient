import "package:getteacher/net/net.dart";
import "package:getteacher/net/reset_password/reset_password_net_model.dart";


Future<void> resetPassword(final ResetPasswordResponseModel model) async {
  await getClient().postJson("/auth/reset-password/reset", model.toJson());
}
