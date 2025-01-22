import "package:email_validator/email_validator.dart";
import "package:flutter/material.dart";
import "package:getteacher/common_widgets/submit_button.dart";
import "package:getteacher/net/reset_password/forgot_password.dart";
import "package:getteacher/net/reset_password/forgot_password_net_model.dart";
import "package:getteacher/theme/theme.dart";
import "package:getteacher/theme/widgets.dart";
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
        backgroundColor: AppTheme.backgroundColor,
        
        body: Stack(
          children: <Widget>[

            AppWidgets.fadedBigLogo(),
            AppWidgets.bubblesImage(),

          Center(
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: AppTheme.whiteColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [AppTheme.defaultShadow],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    "Reset your password",
                    style: AppTheme.secondaryHeadingStyle,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Enter the email address associated with your account and we'll send you a code to reset your password.",
                    style: TextStyle(color: AppTheme.secondaryTextColor, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    decoration: AppWidgets.inputDecoration(hint: "Email"),
                    validator: (final String? value) =>
                        value != null && EmailValidator.validate(value) ? null : "Invalid email",
                    onChanged: (final String value) {
                      setState(() {
                        model = model.copyWith(email: () => value);
                      });
                    },
                  ),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 20),
                  TextButton(
                    child: const Text("Back to Login", style: AppTheme.linkTextStyle),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute<void>(
                          builder: (final BuildContext context) => LoginScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
