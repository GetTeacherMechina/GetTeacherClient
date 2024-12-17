import "dart:async";

import "package:flutter/material.dart";
import "package:getteacher/common_widgets/submit_button.dart";
import "package:getteacher/net/login/login.dart";
import "package:getteacher/views/login_screen/login_model.dart";
import "package:getteacher/views/main_screen/main_screen.dart";

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  LoginModel model = const LoginModel();

  late final TextEditingController emailController =
      TextEditingController(text: model.email);
  late final TextEditingController passwordController =
      TextEditingController(text: model.password);

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Row(
          children: <Widget>[
            const Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  const Spacer(
                    flex: 1,
                  ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: "Email",
                    ),
                    onChanged: (final String value) {
                      model = model.copyWith(email: () => value);
                    },
                  ),
                  TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      hintText: "Password",
                    ),
                    onChanged: (final String value) {
                      model = model.copyWith(password: () => value);
                    },
                  ),
                  const Spacer(
                    flex: 4,
                  ),
                  SubmitButton(
                    validate: () => true,
                    submit: () async {
                      await login(model.toRequest());
                      unawaited(
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute<void>(
                            builder: (final BuildContext context) =>
                                const MainScreen(),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      );
}
