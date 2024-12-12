import "package:flutter/material.dart";
import "package:getteacher/views/login_screen/login_model.dart";

class LoginScreen extends StatefulWidget{
  LoginScreen({super.key});
  
  @override
  State<StatefulWidget> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  LoginModel model = const LoginModel();

  late final TextEditingController emailController
    = TextEditingController(text: model.email);
  late final TextEditingController passwordController
    = TextEditingController(text: model.password);

  @override
  Widget build(final BuildContext context) => Scaffold(
    body: Form(

      child: Row(
        children: <Widget> [
          const Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget> [
                const Spacer(
                  flex: 1,
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                        hintText: "email",),
                ),
                TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: "password",
                  ),
                ),
                const Spacer(
                  flex: 4,
                ),
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