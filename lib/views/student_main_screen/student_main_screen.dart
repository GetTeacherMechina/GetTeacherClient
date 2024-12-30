import "package:flutter/material.dart";
import "package:getteacher/net/call/call_model.dart";
import "package:getteacher/net/call_teacher/call_teacher.dart";
import "package:getteacher/net/profile/profile_net_model.dart";
import "package:getteacher/net/web_socket_json_listener.dart";
import "package:getteacher/views/call_screen.dart";

class StudentMainScreen extends StatefulWidget {
  const StudentMainScreen({super.key, required this.profile});
  final ProfileResponseModel profile;

  @override
  State<StudentMainScreen> createState() => _StudentMainScreenState();
}

class _StudentMainScreenState extends State<StudentMainScreen> {
  WebSocketJson? webSocketJson;

  final TextEditingController controller = TextEditingController();

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
        appBar: AppBar(
          centerTitle: true,
          leading: const Icon(Icons.book),
          title: Text("Hello ${widget.profile.fullName}"),
          surfaceTintColor: Theme.of(context).primaryColor,
        ),
        body: Row(
          children: [
            const Spacer(),
            Expanded(
              child: Column(
                children: [
                  const Spacer(
                    flex: 4,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(hintText: "Subject"),
                      controller: controller,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () async {
                        await callTeacher(controller.text);
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.call),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Call a teacher")
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
            const Spacer()
          ],
        ),
      );
}
