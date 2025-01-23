import "package:flutter/material.dart";
import "package:getteacher/net/meeting_history/meeting_history_net_model.dart";
import "package:getteacher/net/meeting_history/meetings_history.dart";
import "package:getteacher/net/net.dart";
import "package:getteacher/net/profile/profile_net_model.dart";

/*
class MeetingHistoryScreen extends StatefulWidget {
  MeetingHistoryScreen({super.key, required this.profile});

  @override
  State<StatefulWidget> createState() =>
      _MeetingHistoryScreen(profile: profile);
  final ProfileResponseModel profile;
}

class _MeetingHistoryScreen extends State<MeetingHistoryScreen> {
  _MeetingHistoryScreen({required this.profile});
  final ProfileResponseModel profile;

  late final Future<MeetingsHistoryResponse> respond = getMeetingsHistory(
    MeetingsHistoryRequest(
      isStudent: profile.isStudent,
      isTeacher: profile.isTeacher,
    ),
  );

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("History"),
          centerTitle: true,
        ),
        body: FutureBuilder<MeetingsHistoryResponse>(
          future: respond,
          builder: (
            final BuildContext context,
            final AsyncSnapshot<MeetingsHistoryResponse> snapshot,
          ) =>
              snapshot.mapSnapshot(
            onSuccess: (final MeetingsHistoryResponse response) => Center(
              child: Column(
                children: response.history
                    .map(
                      (final Meeting h) => Row(
                        children: <Widget>[
                          Text(
                            h.subjectName,
                          ),
                          const Spacer(
                            flex: 4,
                          ),
                          Text(
                            "start time: ${h.startTime}",
                          ),
                          const Spacer(
                            flex: 4,
                          ),
                          Text(
                            "end time: ${h.endTime}",
                          ),
                          const Spacer(
                            flex: 4,
                          ),
                          Text(
                            "prtner name ${h.partnerName}",
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      );
}*/
