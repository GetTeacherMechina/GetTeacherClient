import "package:email_validator/email_validator.dart";
import "package:flutter/material.dart";
import "package:getteacher/common_widgets/jump_to_main_screen.dart";
import "package:getteacher/common_widgets/submit_button.dart";
import "package:getteacher/net/login/login.dart";
import "package:getteacher/theme/theme.dart";
import "package:getteacher/theme/widgets.dart";
import "package:getteacher/views/login_screen/login_model.dart";
import "package:getteacher/views/register_screen/register_screen.dart";
import "package:getteacher/views/reset_password_screen/forgot_my_password_screen.dart";

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

  bool _obscurePassword = true;

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(final BuildContext context) => Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        body: Stack(
          children: <Widget>[
            AppWidgets.bottomBubblesImage(),
            ListView(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 8,
              ),
              children: <Widget>[
                _menuBar(context),
                _loginBody(context),
              ],
            ),
            AppWidgets.logoImage(),
          ],
        ),
      );

  Widget _menuBar(final BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                AppWidgets.menuItem(title: "Home"),
                AppWidgets.menuItem(title: "Chat"),
                AppWidgets.menuItem(title: "Something"),
                AppWidgets.menuItem(title: "Help"),
              ],
            ),
            Row(
              children: <Widget>[
                AppWidgets.menuItem(title: "Sign In", isActive: false),
                _registerButton(context),
              ],
            ),
          ],
        ),
      );

  Widget _registerButton(final BuildContext context) => GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute<void>(
              builder: (final BuildContext context) => RegisterScreen(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.defaultButtonBack,
            borderRadius: BorderRadius.circular(15),
            boxShadow: <BoxShadow>[AppTheme.defaultShadow],
          ),
          child: const MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Text(
              "Sign Up",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.linkColor,
              ),
            ),
          ),
        ),
      );

  Widget _loginBody(final BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 50.0,
                right: 50.0,
                bottom: 50.0,
                top: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Sign In to GetTeacher",
                    style: AppTheme.headingStyle,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Don't have an account yet?",
                    style: TextStyle(
                      color: AppTheme.secondaryTextColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute<void>(
                          builder: (final BuildContext context) =>
                              RegisterScreen(),
                        ),
                      );
                    },
                    child: const MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        "Register here!",
                        style: TextStyle(
                          color: AppTheme.linkColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / 6,
              ),
              child: _loginForm(),
            ),
          ),
        ],
      );

  Widget _loginForm() => Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 40),
            TextFormField(
              controller: emailController,
              decoration: AppWidgets.inputDecoration(hint: "Email"),
              validator: (final String? value) =>
                  value != null && EmailValidator.validate(value)
                      ? null
                      : "Invalid email",
              onChanged: (final String value) =>
                  model = model.copyWith(email: () => value),
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
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (final BuildContext context) =>
                          ForgotMyPasswordScreen(),
                    ),
                  );
                },
                child: const MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0, right: 2.0),
                    child: Text(
                      " Forgot your password?",
                      style: TextStyle(
                        color: AppTheme.linkColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: <BoxShadow>[AppTheme.defaultShadow],
              ),
              child: SubmitButton(
                validate: () => _formKey.currentState!.validate(),
                submit: () async {
                  await login(model.toRequest(), context);
                  final Widget nextScreen = await getMainScreen();
                  await Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (final BuildContext context) => nextScreen,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
}
