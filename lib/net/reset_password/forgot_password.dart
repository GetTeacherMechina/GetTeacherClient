import "package:getteacher/net/reset_password/forgot_password_net_model.dart";
import "package:getteacher/net/net.dart";


Future<String> forgotPassword(final ForgotPasswordModelRequest model) async {
  final Map<String, dynamic> response = await getClient().postJson("/reset-password/forget-password", model.toJson());
  return ForgotPasswordModelRespons.fromJson(response).token;
}