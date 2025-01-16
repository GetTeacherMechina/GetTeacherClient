import "package:getteacher/net/reset_password/forgot_password_net_model.dart";
import "package:getteacher/net/net.dart";


Future<void> forgotPassword(final ForgotPasswordRequestModel model) async {
  await getClient().postJson("/auth/reset-password/forgot", model.toJson());
}