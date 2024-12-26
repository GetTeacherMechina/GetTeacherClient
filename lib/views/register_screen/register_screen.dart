import "package:email_validator/email_validator.dart";
import "package:flutter/material.dart";
import "package:getteacher/common_widgets/submit_button.dart";
import "package:getteacher/net/register/register.dart";
import "package:getteacher/views/login_screen/login_screen.dart";
import "package:getteacher/views/register_screen/register_model.dart";
import "package:getteacher/views/register_screen/user_role_input.dart";
import "package:getteacher/views/register_screen/user_role_selector.dart";

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

  @override
  void initState() {
    super.initState();
  }

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
                            controller: nameController,
                            decoration: const InputDecoration(
                              hintText: "Full name",
                            ),
                            onChanged: (final String value) {
                              model = model.copyWith(fullName: () => value);
                            },
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(hintText: "Email"),
                            controller: emailController,
                            onChanged: (final String value) {
                              setState(() {
                                model = model.copyWith(email: () => value);
                              });
                            },
                            validator: (final String? email) =>
                                email != null && EmailValidator.validate(email)
                                    ? null
                                    : "Invalid Email",
                          ),
                          UserRoleSelector(
                            role: model.role,
                            onNewUserRole: (final UserRole role) {
                              setState(() {
                                model = model.copyWith(role: () => role);
                              });
                            },
                          ),
                          UserRoleInput(
                            role: model.role,
                            onRoleChanged: (final UserRole role) {
                              setState(() {
                                model = model.copyWith(role: () => role);
                              });
                            },
                          ),
                          TextFormField(
                            obscureText: true,
                            decoration:
                                const InputDecoration(hintText: "Password"),
                            onChanged: (final String value) {
                              setState(() {
                                model = model.copyWith(password: () => value);
                              });
                            },
                          ),
                          TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: "Confirm password",
                            ),
                            onChanged: (final String value) {
                              setState(() {
                                model = model.copyWith(
                                  confirmedPassword: () => value,
                                );
                              });
                            },
                            validator: (final String? value) =>
                                model.password == model.confirmedPassword
                                    ? null
                                    : "Passwords don't match",
                          ),
                        ],
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    TextButton(
                      child: const Text("Already have a profile?"),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute<void>(
                            builder: (final BuildContext context) =>
                                LoginScreen(),
                          ),
                        );
                      },
                    ),
                    SubmitButton(
                      validate: () => _formKey.currentState!.validate(),
                      submit: () async {
                        await register(model.intoRegisterRequest(), context);
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
