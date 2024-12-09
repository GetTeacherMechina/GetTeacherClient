import "package:flutter/material.dart";
import "package:getteacher/net/hello/hello.dart";
import "package:getteacher/views/main_screen/main_screenl_model.dart";
import "package:getteacher/views/profile_screen/profile_screen.dart";

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Model model = const Model();

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.person),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (a) => const ProfileScreen()),
              ),
            ),
            title: const Text("Profle"),
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    final Hello hello = await fetchHello();

                    setState(() {
                      model = model.copyWith(hello: () => hello);
                    });
                  },
                  child: Text("Message from server: ${model.hello.message}"),
                ),
              ],
            ),
          ),
        ),
      );
}
