import "package:flutter/material.dart";
import "package:getteacher/common_widgets/is_online.dart";
import "package:getteacher/common_widgets/main_screen_drawer.dart";
import "package:getteacher/net/call/meeting_response.dart";
import "package:getteacher/net/profile/profile_net_model.dart";
import "package:getteacher/net/teacher_meeting_searching/teacher_meeting_searching.dart";
import "package:getteacher/net/web_socket_json_listener.dart";
import "package:getteacher/theme/widgets.dart";
import "package:getteacher/views/call_screen.dart";
import "package:getteacher/theme/theme.dart";

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
  late WebSocketJson connection;

  bool readyForCalling = false;

  @override
  void dispose() {
    super.dispose();
    connection.close();
  }

  @override
  void initState() {
    super.initState();
    connection = WebSocketJson.connect(
      (final Map<String, dynamic> json) {
        final MeetingResponse callModel = MeetingResponse.fromJson(json);
        setState(() {
          readyForCalling = false;
        });
        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (final BuildContext context) => CallScreen(
                guid: callModel.meetingGuid,
                shouldStartCall: true,
                isStudent: false,
              ),
            ),
          );
        }
      },
    );
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
          title: Text(
            "Hello ${widget.profile.fullName}",
            style: AppTheme.bodyTextStyle,
          ),
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: AppTheme.whiteColor,
        ),
        drawer: MainScreenDrawer(
          profile: widget.profile,
        ),
        body: Stack(
          children: <Widget>[
            AppWidgets.homepageLogo(),
            AppWidgets.coverBubblesImage(),
            Center(
              child: Container(
                width: 400,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: AppTheme.whiteColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [AppTheme.defaultShadow],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      "Ready to receive calls",
                      style: AppTheme.headingStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () async {
                        if (readyForCalling) {
                          await stopMeetingSearching();
                        } else {
                          await startMeetingSearching();
                        }
                        setState(() {
                          readyForCalling = !readyForCalling;
                        });
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: readyForCalling
                            ? AppTheme.primaryColor
                            : AppTheme.hintTextColor,
                        child: readyForCalling
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.search,
                                size: 50.0,
                                color: Colors.white,
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      readyForCalling
                          ? "Searching for students..."
                          : "Tap to start searching",
                      style: AppTheme.bodyTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
