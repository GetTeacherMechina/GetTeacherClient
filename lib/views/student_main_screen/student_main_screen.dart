import "dart:async";
import "dart:convert";

import "package:flutter/material.dart";
import "package:getteacher/common_widgets/main_screen_drawer.dart";
import "package:getteacher/net/call/meeting_response.dart";
import "package:getteacher/net/call/student_call_model.dart";
import "package:getteacher/net/student_meeting_searching/student_meeting_searching.dart";
import "package:getteacher/net/profile/profile_net_model.dart";
import "package:getteacher/net/web_socket_json_listener.dart";
import "package:getteacher/views/call_screen.dart";
import "package:getteacher/views/student_main_screen/approve_teacher.dart";
import "package:getteacher/views/student_main_screen/student_search_screen/student_search_screen.dart";

const String messageType = "MessageType";
const String meetingStartNotification = "MeetingStartNotification";
const String csgoContract = "CsGoContract";
const String error = "Error";

class StudentMainScreen extends StatefulWidget {
  const StudentMainScreen({super.key, required this.profile});
  final ProfileResponseModel profile;

  @override
  State<StudentMainScreen> createState() => _StudentMainScreenState();
}

class _StudentMainScreenState extends State<StudentMainScreen> {
  late WebSocketJson webSocketJson;

  String subject = "";
  bool waitingForCall = false;

  void startMeeting(final Map<String, dynamic> json) {
    final MeetingResponse meeting = MeetingResponse.fromJson(json);
    setState(() {
      waitingForCall = false;
    });

    if (mounted) {
      unawaited(
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (final BuildContext context) => CallScreen(
              guid: meeting.meetingGuid,
              shouldStartCall: false,
            ),
          ),
        ),
      );
    }
  }

  void csgoApprove(final Map<String, dynamic> json) async {
    final StudentCallModel studentCall = StudentCallModel.fromJson(json);
    final bool approved = await showApproveTeacher(context, studentCall);
    if (!approved) {
      webSocketJson.webSocket.sink.add(utf8.encode("👎🏿"));
      return;
    }

    webSocketJson.webSocket.sink.add(utf8.encode("👍🏻"));
  }

  @override
  void initState() {
    super.initState();

    WebSocketJson.connect((final Map<String, dynamic> json) async {
      if (json[messageType] == csgoContract) {
        csgoApprove(json);
      } else if (json[messageType] == meetingStartNotification) {
        final MeetingResponse meeting = MeetingResponse.fromJson(json);
        setState(() {
          waitingForCall = false;
        });

        if (mounted) {
          unawaited(
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (final BuildContext context) => CallScreen(
                  guid: meeting.meetingGuid,
                  shouldStartCall: false,
                  isStudent: true,
                ),
              ),
            ),
          );
        }
      } else if (json[messageType] == error) {}
    }).then((final WebSocketJson ws) {
      webSocketJson = ws;
    });
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        drawer: MainScreenDrawer(profile: widget.profile),
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
                    flex: 7,
                    child: StudentSearchWidget(
                      selectedItem: subject,
                      onSubjectSelected: (final String subject) {
                        setState(() {
                          this.subject = subject;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (subject.isEmpty) {
                          return;
                        }
                        if (!waitingForCall) {
                          await startSearchingForTeacher(subject);
                          setState(() {
                            waitingForCall = true;
                          });
                        } else {
                          await stopSearchingForTeacher();
                          setState(() {
                            waitingForCall = false;
                          });
                        }
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
