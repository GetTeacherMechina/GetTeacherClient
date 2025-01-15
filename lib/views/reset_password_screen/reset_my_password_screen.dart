import "package:flutter/material.dart";
import "package:getteacher/common_widgets/submit_button.dart";
import "package:getteacher/net/reset_password/reset_password.dart";
import "package:getteacher/net/reset_password/reset_password_net_model.dart";
import "package:getteacher/views/login_screen/login_screen.dart";
import "package:getteacher/views/reset_password_screen/reset_my_password_model.dart";

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({super.key, required this.token, required this.email});

  @override
  State<StatefulWidget> createState() => _ResetPasswordScreen(token: token, email: email);

  final String token;
  final String email;
}

class _ResetPasswordScreen extends State<StatefulWidget> {
  _ResetPasswordScreen({required this.token, required this.email});

  final String token;
  final String email;
  
  ResetMyPasswordModel model = const ResetMyPasswordModel();

  final GlobalKey<FormState> _formKey = GlobalKey();

  late final TextEditingController confirmPasswordController =
      TextEditingController(text: model.confirmPassword);
  late final TextEditingController passwordController =
      TextEditingController(text: model.password);

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
                      flex: 8,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            obscureText: true,
                            controller: passwordController,
                            decoration: const InputDecoration(
                              hintText: "Password",
                            ),
                            onChanged: (final String value) {
                              model = model.copyWith(password: () => value);
                            },
                          ),
                          TextField(
                            obscureText: true,
                            controller: confirmPasswordController,
                            decoration: const InputDecoration(
                              hintText: "Confirm Password",
                            ),
                            onChanged: (final String value) {
                              model = model.copyWith(confirmPassword: () => value);
                            },
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
                        await resetPassword(ResetPasswordResponsModle(
                          email: email,
                          token: token,
                          password: model.password,
                          confirmPassword: model.confirmPassword
                        ),);
                        await Navigator.of(context).pushReplacement(
                          MaterialPageRoute<void>(
                            builder: (final BuildContext context) => LoginScreen(),
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