import "package:flutter/material.dart";
import "package:getteacher/common_widgets/submit_button.dart";
import "package:getteacher/net/reset_password/code_check.dart";
import "package:getteacher/net/reset_password/code_check_net_model.dart";
import "package:getteacher/views/reset_password_screen/reset_my_password_screen.dart";
import "package:getteacher/views/reset_password_screen/reset_password_code_model.dart";

class ResetPasswordScreenCode extends StatefulWidget {
  ResetPasswordScreenCode({super.key, required this.token, required this.email});

  @override
  State<StatefulWidget> createState() => _ResetPasswordScreenCode(token: token, email: email);

  final String token;
  final String email;
}

class _ResetPasswordScreenCode extends State<StatefulWidget> {
  _ResetPasswordScreenCode({required this.token, required this.email});

  final String token;
  final String email;

  ForgotMyPasswordCodeModel model = const ForgotMyPasswordCodeModel();

  late final TextEditingController codeController =
      TextEditingController(text: model.code);

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(final BuildContext context) => Scaffold(
        key: _formKey,
        body: Form(
          key: _formKey,
          child: Row(
            children: <Widget>[
              const Spacer(
                flex: 8,
              ),
              Expanded(
                flex: 8,
                child: Column(
                  children: <Widget>[
                    const Spacer(
                      flex: 1,
                    ),
                    TextFormField(
                      controller: codeController,
                      decoration: const InputDecoration(
                        hintText: "code",
                      ),
                      onChanged: (final String value) {
                        model = model.copyWith(code: () => value);
                      },
                    ),
                    const Spacer(
                      flex: 4,
                    ),
                    SubmitButton(
                      validate: () => _formKey.currentState!.validate(),
                      submit: () async {
                        await checkCode(ResetPasswordCodeRequstModel(code: model.code, token: token));
                        await Navigator.of(context).pushReplacement(
                          MaterialPageRoute<void>(
                            builder: (final BuildContext context) =>
                                ResetPasswordScreen(token: token, email: email,),
                          ),
                        );
                      },
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              ),
              const Spacer(
                flex: 8,
              ),
            ],
          ),
        ),
      );
}
