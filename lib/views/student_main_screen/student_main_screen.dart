import "dart:async";
import "dart:convert";

import "package:flutter/material.dart";
import "package:getteacher/common_widgets/main_screen_drawer.dart";
import "package:getteacher/net/call/student_call_model.dart";
import "package:getteacher/net/call_teacher/call_teacher.dart";
import "package:getteacher/net/profile/profile_net_model.dart";
import "package:getteacher/net/web_socket_json_listener.dart";
import "package:getteacher/views/call_screen.dart";
import "package:getteacher/views/student_main_screen/approve_teacher.dart";

class StudentMainScreen extends StatefulWidget {
  const StudentMainScreen({super.key, required this.profile});
  final ProfileResponseModel profile;

  @override
  State<StudentMainScreen> createState() => _StudentMainScreenState();
}

class _StudentMainScreenState extends State<StudentMainScreen> {
  late WebSocketJson webSocketJson;

  final TextEditingController controller = TextEditingController();
  bool waitingForCall = false;

  @override
  void initState() {
    super.initState();

    WebSocketJson.connect((final Map<String, dynamic> json) async {
      final StudentCallModel studentCall = StudentCallModel.fromJson(json);
      final bool approved = await showApproveTeacher(context, studentCall);
      if (!approved) {
        webSocketJson.webSocket.sink.add(utf8.encode("👎🏿"));
        return;
      }

      webSocketJson.webSocket.sink.add(utf8.encode("👍🏻"));
      setState(() {
        waitingForCall = false;
      });

      if (mounted) {
        unawaited(
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (final BuildContext context) =>
                  CallScreen(message: studentCall.meetingResponse),
            ),
          ),
        );
      }
    }).then((final WebSocketJson ws) {
      webSocketJson = ws;
    });
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        drawer: MainScreenDrawer(profile: widget.profile),
        appBar: AppBar(
          centerTitle: true,
          leading: const Icon(Icons.book),
          title: Text("Hello ${widget.profile.fullName}"),
          surfaceTintColor: Theme.of(context).primaryColor,
        ),
        body: Row(
          children: <Widget>[
            const Spacer(),
            Expanded(
              child: Column(
                children: <Widget>[
                  const Spacer(
                    flex: 4,
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () async {
                        await callTeacher(controller.text);
                        setState(() {
                          waitingForCall = true;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: waitingForCall
                            ? <Widget>[
                                const CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ]
                            : <Widget>[
                                const Icon(Icons.call),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text("Call a teacher"),
                              ],
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 4,
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      );
}
