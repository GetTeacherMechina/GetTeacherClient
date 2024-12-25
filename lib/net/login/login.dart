import "dart:async";

import "package:flutter/material.dart";
import "package:getteacher/net/login/login_net_model.dart";
import "package:getteacher/net/net.dart";
import "package:getteacher/utils/local_jwt.dart";

Future<void> login(
  final LoginRequestModel request,
  final BuildContext context,
) async {
  final Map<String, dynamic> response =
      await getClient().postJson("/auth/login", request.toJson());

  final LoginResponseModel jwt = LoginResponseModel.fromJson(response);
  getClient().authorize(jwt.jwtToken);

  // saves it to local storage
  LocalJwt.setLocalJwt(jwt.jwtToken);
}
