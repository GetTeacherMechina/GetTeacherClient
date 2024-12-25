import "package:flutter/material.dart";
import "package:getteacher/net/web_socket_json_listener.dart";

class TeacherMainScreen extends StatefulWidget {
  const TeacherMainScreen({super.key});

  @override
  State<TeacherMainScreen> createState() => _TeacherMainScreenState();
}

class _TeacherMainScreenState extends State<TeacherMainScreen> {
  late WebSocketJson connection;

  bool readyForCalling = false;

  @override
  void initState() async {
    super.initState();
    connection = await WebSocketJson.connect(
      (final Map<String, dynamic> json) {
        if (json["called_by"] != null) {
          print("You were called!");
        }
      },
    );
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Center(
          child: RawMaterialButton(
            onPressed: () {},
            elevation: 2.0,
            fillColor: Colors.blue,
            constraints: const BoxConstraints(minWidth: 0.0),
            child: const Icon(
              Icons.pause,
              size: 35.0,
            ),
            padding: const EdgeInsets.all(15.0),
            shape: const CircleBorder(),
          ),
        ),
      );
}
