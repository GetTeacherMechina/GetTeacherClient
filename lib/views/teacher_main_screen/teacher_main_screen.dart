import "package:flutter/material.dart";
import "package:getteacher/common_widgets/main_screen_drawer.dart";
import "package:getteacher/net/call/meeting_response.dart";
import "package:getteacher/net/profile/profile_net_model.dart";
import "package:getteacher/net/teacher_meeting_searching/teacher_meeting_searching.dart";
import "package:getteacher/net/web_socket_json_listener.dart";
import "package:getteacher/views/call_screen.dart";

class TeacherMainScreen extends StatefulWidget {
  const TeacherMainScreen({
    super.key,
    required this.profile,
  });

  final ProfileResponseModel profile;

  @override
  State<TeacherMainScreen> createState() => _TeacherMainScreenState();
}

class _TeacherMainScreenState extends State<TeacherMainScreen> {
  WebSocketJson? connection;

  bool readyForCalling = false;

  @override
  void dispose() {
    super.dispose();
    connection?.close();
  }

  @override
  void initState() {
    super.initState();
    WebSocketJson.connect(
      (final Map<String, dynamic> json) {
        final MeetingResponse callModel = MeetingResponse.fromJson(json);
        setState(() {
          readyForCalling = false;
        });
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
        appBar: AppBar(
          centerTitle: true,
          leading: Builder(
            builder: (final BuildContext context) => IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          title: Text("Hello ${widget.profile.fullName}"),
          // surfaceTintColor: Theme.of(context).primaryColor,
        ),
        drawer: MainScreenDrawer(
          profile: widget.profile,
        ),
        body: Row(
          children: <Widget>[
            const Spacer(),
            Expanded(
              child: Column(
                children: <Widget>[
                  const Spacer(flex: 4),
                  Expanded(
                    flex: 1,
                    child: RawMaterialButton(
                      onPressed: () async {
                        if (readyForCalling) {
                          await stopMeetingSearching();
                        } else {
                          await startMeetingSearching();
                        }
                        setState(() {
                          readyForCalling = !readyForCalling;
                        });
                      },
                      elevation: 2.0,
                      fillColor: Colors.blue,
                      constraints: const BoxConstraints(minWidth: 0.0),
                      child: readyForCalling
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.search,
                              size: 35.0,
                            ),
                      padding: const EdgeInsets.all(30.0),
                      shape: const CircleBorder(),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      );
}
