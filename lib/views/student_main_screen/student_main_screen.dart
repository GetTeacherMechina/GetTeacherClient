import "dart:async";
import "dart:convert";

import "package:flutter/material.dart";
import "package:getteacher/common_widgets/main_screen_drawer.dart";
import "package:getteacher/net/call/meeting_response.dart";
import "package:getteacher/net/call/student_call_model.dart";
import "package:getteacher/net/student_meeting_searching/student_meeting_searching.dart";
import "package:getteacher/net/profile/profile_net_model.dart";
import "package:getteacher/net/web_socket_json_listener.dart";
import "package:getteacher/theme/theme.dart";
import "package:getteacher/theme/widgets.dart";
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
              isStudent: false,
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

    webSocketJson =
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
    });
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        drawer: MainScreenDrawer(
          profile: widget.profile,
          webSocketJson: webSocketJson,
        ),
        backgroundColor: AppTheme.backgroundColor,
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
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: AppTheme.whiteColor,
        ),
        body: Stack(
          children: <Widget>[
            AppWidgets.homepageLogo(),
            AppWidgets.coverBubblesImage(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: StudentSearchWidget(
                      selectedItem: subject,
                      onSubjectSelected: (final String subject) {
                        setState(() {
                          this.subject = subject;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 150),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (subject.isEmpty) {
                          return;
                        }
                        if (!waitingForCall) {
                          setState(() {
                            waitingForCall = true;
                          });
                          await startSearchingForTeacher(subject);
                        } else {
                          setState(() {
                            waitingForCall = false;
                          });
                          await stopSearchingForTeacher();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: AppTheme.whiteColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: waitingForCall
                          ? const CircularProgressIndicator(
                              color: AppTheme.whiteColor,
                            )
                          : const Text("Call a Teacher"),
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
