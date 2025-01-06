import "package:flutter/material.dart";
import "package:getteacher/common_widgets/jump_to_main_screen.dart";
import "package:getteacher/net/net.dart";
import "package:getteacher/net/validate/validate.dart";
import "package:getteacher/utils/local_jwt.dart";
import "package:getteacher/views/register_screen/register_screen.dart";

Future<Widget> mainScreenFromLogin() async {
  final String? jwt = await LocalJwt.getLocalJwt();
  if (jwt != null) {
    getClient().authorize(jwt);
    try {
      // TOOD handle exit codes for unauthorized versos online
      await validate();
      getClient().authorize(jwt);
      return await getMainScreen();
    } catch (e) {
      LocalJwt.clearJwt();
      getClient().unauthorize();
    }
  }
  return RegisterScreen();
}

void main() async {
  final Widget initialScreen = await mainScreenFromLogin();

  runApp(
    App(
      mainScreen: initialScreen,
    ),
  );
}

class App extends StatelessWidget {
  const App({
    super.key,
    required this.mainScreen,
  });

  final Widget mainScreen;

  @override
  Widget build(final BuildContext context) => MaterialApp(
        theme: ThemeData(useMaterial3: false),
        debugShowCheckedModeBanner: false,
        home: mainScreen,
      );
}
