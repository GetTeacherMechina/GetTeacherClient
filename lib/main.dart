import "package:flutter/material.dart";
import "package:getteacher/logic.dart";

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Model model = const Model();

  @override
  Widget build(final BuildContext context) => MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              children: <Widget>[
                const Text("Hello World!"),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      model = model.incrementI();
                    });
                  },
                  child: const Text(""),
                ),
              ],
            ),
          ),
        ),
      );
}
