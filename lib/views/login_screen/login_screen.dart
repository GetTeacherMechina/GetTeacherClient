import "package:email_validator/email_validator.dart";
import "package:flutter/material.dart";
import "package:getteacher/common_widgets/jump_to_main_screen.dart";
import "package:getteacher/common_widgets/submit_button.dart";
import "package:getteacher/net/login/login.dart";
import "package:getteacher/views/login_screen/login_model.dart";
import "package:getteacher/views/register_screen/register_screen.dart";

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

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(final BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFFf5f5f5),
        body: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 8,),
          children: <Widget>[
            _menuBar(context),
            _loginBody(context),
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
              _menuItem(title: "Home"),
              _menuItem(title: "Chat"),
              _menuItem(title: "Something"),
              _menuItem(title: "Help"),
            ],
          ),
          Row(
            children: <Widget>[
              _menuItem(title: "Sign In", isActive: false),
              _registerButton(context),
            ],
          ),
        ],
      ),
    );

  Widget _menuItem({required final String title, final bool isActive = false}) => Padding(
      padding: const EdgeInsets.only(right: 75),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.deepPurple : Colors.grey,
          ),
        ),
      ),
    );

  Widget _registerButton(final BuildContext context) => GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (final BuildContext context) => RegisterScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 10,
              blurRadius: 12,
            ),
          ],
        ),
        child: const Text(
          "Register",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
      ),
    );

  Widget _loginBody(final BuildContext context) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Sign In to GetTeacher",
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "If you don't have an account",
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (final BuildContext context) => RegisterScreen()),
                    );
                  },
                  child: const Text(
                    "Register here!",
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 6),
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
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: "Email",
              filled: true,
              fillColor: Colors.blueGrey[50],
              contentPadding: const EdgeInsets.only(left: 30),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (final String? value) => value != null && EmailValidator.validate(value)
                ? null
                : "Invalid email",
            onChanged: (final String value) => model = model.copyWith(email: () => value),
          ),
          const SizedBox(height: 20),
          TextField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
              hintText: "Password",
              filled: true,
              fillColor: Colors.blueGrey[50],
              contentPadding: const EdgeInsets.only(left: 30),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (final String value) => model = model.copyWith(password: () => value),
          ),
          const SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(30),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.deepPurple.withOpacity(0.4),
                  spreadRadius: 5,
                  blurRadius: 15,
                ),
              ],
            ),
            child: SubmitButton(
              validate: () => _formKey.currentState!.validate(),
              submit: () async {
                await login(model.toRequest(), context);
                final Widget nextScreen = await getMainScreen();
                await Navigator.of(context).pushReplacement(
                  // ignore: always_specify_types
                  MaterialPageRoute(builder: (final BuildContext context) => nextScreen),
                );
              },
            ),
          ),
        ],
      ),
    );
}
