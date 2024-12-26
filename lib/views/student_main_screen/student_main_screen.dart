import "package:flutter/material.dart";
import "package:getteacher/net/call/call_model.dart";
import "package:getteacher/net/call_teacher/call_teacher.dart";
import "package:getteacher/net/web_socket_json_listener.dart";
import "package:getteacher/views/call_screen.dart";

class StudentMainScreen extends StatefulWidget {
  const StudentMainScreen({super.key});

  @override
  State<StudentMainScreen> createState() => _StudentMainScreenState();
}

class _StudentMainScreenState extends State<StudentMainScreen> {
  WebSocketJson? webSocketJson;

  @override
  void initState() {
    super.initState();

    WebSocketJson.connect((final Map<String, dynamic> json) {
      final CallModel callModel = CallModel.fromJson(json);
      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (final BuildContext context) =>
                CallScreen(message: callModel),
          ),
        );
      }
    }).then((final WebSocketJson ws) {
      webSocketJson = ws;
    });
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
