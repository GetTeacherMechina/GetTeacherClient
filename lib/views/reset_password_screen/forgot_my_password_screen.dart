import "package:email_validator/email_validator.dart";
import "package:flutter/material.dart";
import "package:getteacher/common_widgets/submit_button.dart";
import "package:getteacher/net/reset_password/forgot_password.dart";
import "package:getteacher/net/reset_password/forgot_password_net_model.dart";
import "package:getteacher/views/login_screen/login_screen.dart";
import "package:getteacher/views/reset_password_screen/forgot_my_password_model.dart";
import "package:getteacher/views/reset_password_screen/reset_my_password_screen.dart";

class ForgotMyPasswordScreen extends StatefulWidget {
  ForgotMyPasswordScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ForgotMyPasswordScreen();
}

class _ForgotMyPasswordScreen extends State<ForgotMyPasswordScreen> {
  ForgotMyPasswordModel model = const ForgotMyPasswordModel();

  late final TextEditingController emailController =
      TextEditingController(text: model.email);

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Form(
          key: _formKey,
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
                      flex: 8,
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
                          const Spacer(
                            flex: 1,
                          ),
                          TextButton(
                            child: const Text("login"),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute<void>(
                                  builder: (final BuildContext context) =>
                                      LoginScreen(),
                                ),
                              );
                            },
                          ),
                          const Spacer(
                            flex: 20,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    SubmitButton(
                      validate: () => _formKey.currentState!.validate(),
                      submit: () async {
                        await forgotPassword(
                            ForgotPasswordRequestModel(email: model.email));
                        await Navigator.of(context).pushReplacement(
                          MaterialPageRoute<void>(
                            builder: (final BuildContext context) =>
                                ResetPasswordScreen(email: model.email),
                          ),
                        );
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
