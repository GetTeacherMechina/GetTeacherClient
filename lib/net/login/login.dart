import "package:getteacher/net/login/login_net_model.dart";
import "package:getteacher/net/net.dart";

Future<LoginResponseModel> login(final LoginRequestModel request) async {
  final Map<String, dynamic> response =
      await getClient().postJson("/auth/login", request.toJson());

  return LoginResponseModel.fromJson(response);
}
