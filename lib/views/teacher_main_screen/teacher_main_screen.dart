import "package:flutter/material.dart";
import "package:getteacher/net/call/call_model.dart";
import "package:getteacher/net/set_online_status/set_online_status.dart";
import "package:getteacher/net/web_socket_json_listener.dart";
import "package:getteacher/views/call_screen.dart";

class TeacherMainScreen extends StatefulWidget {
  const TeacherMainScreen({super.key});

  @override
  State<TeacherMainScreen> createState() => _TeacherMainScreenState();
}

class _TeacherMainScreenState extends State<TeacherMainScreen> {
  WebSocketJson? connection;

  bool readyForCalling = false;

  @override
  void initState() {
    super.initState();
    WebSocketJson.connect(
      (final Map<String, dynamic> json) {
        final CallModel callModel = CallModel.fromJson(json);
        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (final BuildContext context) =>
                  CallScreen(message: callModel),
            ),
          );
        }
      },
    ).then((final WebSocketJson socket) {
      connection = socket;
    });
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Center(
          child: RawMaterialButton(
            onPressed: () async {
              if (readyForCalling) {
                await stopMettingSearching();
              } else {
                await startMettingSearching();
              }
              setState(() {
                readyForCalling = !readyForCalling;
              });
            },
            elevation: 2.0,
            fillColor: Colors.blue,
            constraints: const BoxConstraints(minWidth: 0.0),
            child: readyForCalling
                ? const CircularProgressIndicator()
                : const Icon(
                    Icons.pause,
                    size: 35.0,
                  ),
            padding: const EdgeInsets.all(15.0),
            shape: const CircleBorder(),
          ),
        ),
      );
}
