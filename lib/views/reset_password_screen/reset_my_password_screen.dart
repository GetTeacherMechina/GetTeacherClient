import "package:flutter/material.dart";
import "package:getteacher/common_widgets/submit_button.dart";
import "package:getteacher/net/reset_password/reset_password.dart";
import "package:getteacher/net/reset_password/reset_password_net_model.dart";
import "package:getteacher/theme/theme.dart";
import "package:getteacher/theme/widgets.dart";
import "package:getteacher/views/login_screen/login_screen.dart";
import "package:getteacher/views/reset_password_screen/forgot_my_password_screen.dart";
import "package:getteacher/views/reset_password_screen/reset_my_password_model.dart";

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  State<StatefulWidget> createState() => _ResetPasswordScreen(email: email);
}

class _ResetPasswordScreen extends State<ResetPasswordScreen> {
  _ResetPasswordScreen({required this.email});

  ResetMyPasswordModel model = const ResetMyPasswordModel();

  final String email;

  final GlobalKey<FormState> _formKey = GlobalKey();

  late final TextEditingController confirmPasswordController =
      TextEditingController(text: model.confirmPassword);
  late final TextEditingController passwordController =
      TextEditingController(text: model.password);
  late final TextEditingController codeController =
      TextEditingController(text: model.code);

  bool _isPasswordReset = false;
  bool _obscurePassword = true;

  @override
  Widget build(final BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            AppWidgets.fadedBigLogo(),
            AppWidgets.bubblesImage(),
            Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 1000),
                transitionBuilder:
                    (final Widget child, final Animation<double> animation) =>
                        FadeTransition(opacity: animation, child: child),
                child:
                    _isPasswordReset ? _successContent() : _resetPasswordForm(),
              ),
            ),
          ],
        ),
      );

  Widget _resetPasswordForm() => Container(
        key: const ValueKey<int>(1),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withAlpha((0.1 * 255).toInt()),
              blurRadius: 15,
              spreadRadius: 5,
            ),
          ],
        ),
        width: 500,
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                "Reset your password",
                style: AppTheme.secondaryHeadingStyle,
              ),
              const SizedBox(height: 15),
              Text(
                "Code sent to $email",
                style: const TextStyle(
                  color: AppTheme.secondaryTextColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscureText: _obscurePassword,
                decoration: AppWidgets.inputDecoration(
                  hint: "Password",
                  obscureText: _obscurePassword,
                  passField: true,
                  onTap: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                onChanged: (final String value) =>
                    model = model.copyWith(password: () => value),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: _obscurePassword,
                decoration: AppWidgets.inputDecoration(
                  hint: "Confirm Password",
                  obscureText: _obscurePassword,
                  passField: true,
                  onTap: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                validator: (final String? value) =>
                    value == passwordController.text
                        ? null
                        : "Passwords don't match",
                onChanged: (final String value) =>
                    model = model.copyWith(confirmPassword: () => value),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: codeController,
                decoration: AppWidgets.inputDecoration(hint: "Code"),
                onChanged: (final String value) {
                  model = model.copyWith(code: () => value);
                },
              ),
              const SizedBox(height: 20),
              SubmitButton(
                validate: () => _formKey.currentState!.validate(),
                submit: () async {
                  await resetPassword(
                    ResetPasswordResponseModel(
                      email: widget.email,
                      code: model.code,
                      password: model.password,
                      confirmPassword: model.confirmPassword,
                    ),
                  );
                  setState(() {
                    _isPasswordReset = true;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextButton(
                child: Text(
                  "$email - not your email?",
                  style: AppTheme.linkTextStyle,
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (final BuildContext context) =>
                          ForgotMyPasswordScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );

  Widget _successContent() => Container(
        key: const ValueKey<int>(2),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withAlpha((0.1 * 255).toInt()),
              blurRadius: 15,
              spreadRadius: 5,
            ),
          ],
        ),
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.check_circle, color: Colors.deepPurple, size: 100),
            const SizedBox(height: 20),
            const Text(
              "Password Reset Successfully!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "You can now log in with your new password.",
              style: TextStyle(color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.deepPurple, // Change button background color
                foregroundColor: Colors.white, // Change text/icon color
                shadowColor: Colors.deepPurpleAccent, // Change shadow color
                elevation: 5, // Adjust shadow elevation
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ), // Adjust padding
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Add rounded corners
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute<void>(
                    builder: (final BuildContext context) => LoginScreen(),
                  ),
                );
              },
              child: const Text("Login"),
            ),
          ],
        ),
      );
}
