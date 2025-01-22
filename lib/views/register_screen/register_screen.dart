import "package:email_validator/email_validator.dart";
import "package:flutter/material.dart";
import "package:getteacher/common_widgets/jump_to_main_screen.dart";
import "package:getteacher/common_widgets/submit_button.dart";
import "package:getteacher/net/register/register.dart";
import "package:getteacher/theme/theme.dart";
import "package:getteacher/views/login_screen/login_screen.dart";
import "package:getteacher/views/register_screen/register_model.dart";
import "package:getteacher/views/register_screen/user_role_input.dart";
import "package:getteacher/views/register_screen/user_role_selector.dart";
import "package:getteacher/views/reset_password_screen/forgot_my_password_screen.dart";

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RegisterModel model = const RegisterModel();

  late final TextEditingController emailController =
      TextEditingController(text: model.email);
  late final TextEditingController nameController =
      TextEditingController(text: model.fullName);
  late final TextEditingController passwordController =
      TextEditingController(text: model.password);
  late final TextEditingController confirmPasswordController =
      TextEditingController(text: model.confirmedPassword);

  bool _obscurePassword = true;

  @override
  Widget build(final BuildContext context) => Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        body: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 8,),
          children: <Widget>[
            _menuBar(context),
            _registerBody(context),
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
              AppTheme.menuItem(title: "Home"),
              AppTheme.menuItem(title: "Chat"),
              AppTheme.menuItem(title: "Something"),
              AppTheme.menuItem(title: "Help"),
            ],
          ),
          Row(
            children: <Widget>[
              AppTheme.menuItem(title: "Sign Up", isActive: false),
              _loginButton(context),
            ],
          ),
        ],
      ),
    );

  Widget _loginButton(final BuildContext context) => GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(builder: (final BuildContext context) => LoginScreen()),
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
            "Login",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.linkColor,
            ),
          ),
        ),
      ),
    );

  Widget _registerBody(final BuildContext context) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 50.0, top: 100.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Create Your Account",
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "Join us by creating a new account",
                  style: TextStyle(color: AppTheme.secondaryTextColor, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 8),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 500),
              child: _registerForm(),
            ),
          ),
        ),
      ],
    );

  Widget _registerForm() => Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: nameController,
            decoration: AppTheme.inputDecoration(hint: "Full Name"),
            onChanged: (final String value) => model = model.copyWith(fullName: () => value),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: emailController,
            decoration: AppTheme.inputDecoration(hint: "Email"),
            validator: (final String? value) => value != null && value.isNotEmpty && EmailValidator.validate(value) ? null : "Invalid email",
            onChanged: (final String value) => model = model.copyWith(email: () => value),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: passwordController,
            obscureText: _obscurePassword,
            decoration: AppTheme.inputDecoration(
              hint: "Password",
              obscureText: _obscurePassword,
              passField: true,
              onTap: () {setState(() {_obscurePassword = !_obscurePassword;});},
            ),
            onChanged: (final String value) => model = model.copyWith(password: () => value),
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
                  "Forgot your password?",
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
          const SizedBox(height: 20),
          TextFormField(
            controller: confirmPasswordController,
            obscureText: _obscurePassword,
            decoration: AppTheme.inputDecoration(
              hint: "Confirm Password",
              obscureText: _obscurePassword,
              passField: true,
              onTap: () {setState(() {_obscurePassword = !_obscurePassword;});},
            ),
            validator: (final String? value) => value == passwordController.text ? null : "Passwords don't match",
            onChanged: (final String value) => model = model.copyWith(confirmedPassword: () => value),
          ),
          const SizedBox(height: 20),
          UserRoleSelector(
            role: model.role,
            onNewUserRole: (final UserRole role) => setState(() => model = model.copyWith(role: () => role)),
          ),
          UserRoleInput(
            role: model.role,
            onRoleChanged: (final UserRole role) {
            setState(() {
            model = model.copyWith(role: () => role);
              });
            },
          ),
          const SizedBox(height: 20),
          SubmitButton(
            validate: () => _formKey.currentState!.validate(),
            submit: () async {
              await register(model.intoRegisterRequest(), context);
              final Widget nextScreen = await getMainScreen();
              await Navigator.of(context).pushReplacement(
                MaterialPageRoute<void>(builder: (final BuildContext context) => nextScreen),
              );
            },
          ),
        ],
      ),
    );
}