import "package:flutter/material.dart";
import "package:getteacher/net/call_teacher/call_teacher.dart";
import "package:getteacher/net/web_socket_json_listener.dart";

class StudentMainScreen extends StatefulWidget {
  const StudentMainScreen({super.key});

  @override
  State<StudentMainScreen> createState() => _StudentMainScreenState();
}

class _StudentMainScreenState extends State<StudentMainScreen> {
  late WebSocketJson webSocketJson;

  @override
  void initState() async {
    super.initState();
    webSocketJson = await WebSocketJson.connect((final _) {});
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              await callTeacher();
            },
            child: const Text("Call"),
          ),
        ),
      );
}
