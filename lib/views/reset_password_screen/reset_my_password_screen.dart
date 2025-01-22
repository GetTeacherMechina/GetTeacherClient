import "package:flutter/material.dart";
import "package:getteacher/common_widgets/submit_button.dart";
import "package:getteacher/net/reset_password/reset_password.dart";
import "package:getteacher/net/reset_password/reset_password_net_model.dart";
import "package:getteacher/views/login_screen/login_screen.dart";
import "package:getteacher/views/reset_password_screen/reset_my_password_model.dart";

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  State<StatefulWidget> createState() => _ResetPasswordScreen();
}

class _ResetPasswordScreen extends State<ResetPasswordScreen> {
  ResetMyPasswordModel model = const ResetMyPasswordModel();

  final GlobalKey<FormState> _formKey = GlobalKey();

  late final TextEditingController confirmPasswordController =
      TextEditingController(text: model.confirmPassword);
  late final TextEditingController passwordController =
      TextEditingController(text: model.password);
  late final TextEditingController codeController =
      TextEditingController(text: model.code);

  bool _isPasswordReset = false;

  @override
  Widget build(final BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (final Widget child, final Animation<double> animation) => FadeTransition(opacity: animation, child: child),
            child: _isPasswordReset ? _successContent() : _resetPasswordForm(),
          ),
        ),
      );

  Widget _resetPasswordForm() => Container(
        key: const ValueKey<int>(1),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
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
              TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(hintText: "Password"),
                onChanged: (final String value) {
                  model = model.copyWith(password: () => value);
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                controller: confirmPasswordController,
                decoration: const InputDecoration(hintText: "Confirm Password"),
                onChanged: (final String value) {
                  model = model.copyWith(confirmPassword: () => value);
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: codeController,
                decoration: const InputDecoration(hintText: "Code"),
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
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              spreadRadius: 5,
            ),
          ],
        ),
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.check_circle, color: Colors.green, size: 100),
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
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute<void>(
                    builder: (final BuildContext context) => LoginScreen(),
                  ),
                );
              },
              child: const Text("Go to Login"),
            ),
          ],
        ),
      );
}
