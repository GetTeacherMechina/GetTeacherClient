import "package:flutter/material.dart";
import "package:getteacher/views/main_screen/main_screen.dart";

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(final BuildContext context) => MaterialApp(
        theme: ThemeData.light(useMaterial3: true),
        home: const MainScreen(),
      );
}
