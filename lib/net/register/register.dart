import "package:flutter/material.dart";
import "package:getteacher/net/login/login.dart";
import "package:getteacher/net/login/login_net_model.dart";
import "package:getteacher/net/net.dart";
import "package:getteacher/net/register/register_net_model.dart";

Future<void> register(
  final RegisterRequestModel request,
  final BuildContext context,
) async {
  await getClient().postJson("/auth/register", request.toJson());

  await login(
    LoginRequestModel(
      email: request.email,
      password: request.password,
    ),
    context,
  );
}
