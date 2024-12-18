import "package:email_validator/email_validator.dart";
import "package:flutter/material.dart";
import "package:getteacher/common_widgets/submit_button.dart";
import "package:getteacher/net/login/login.dart";
import "package:getteacher/views/login_screen/login_model.dart";
import "package:getteacher/views/register_screen/register_screen.dart";

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

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Row(
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
                    Expanded(
                      flex: 6,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              hintText: "Email",
                            ),
                            onChanged: (final String value) {
                              model = model.copyWith(email: () => value);
                            },
                            validator: (final String? value) =>
                                value != null && EmailValidator.validate(value)
                                    ? null
                                    : "Invalid email",
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
                        ],
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    TextButton(
                      child: const Text("Don't have a profile?"),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute<void>(
                            builder: (final BuildContext context) =>
                                RegisterScreen(),
                          ),
                        );
                      },
                    ),
                    SubmitButton(
                      validate: () => _formKey.currentState!.validate(),
                      submit: () async {
                        await login(model.toRequest(), context);
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      );
}
