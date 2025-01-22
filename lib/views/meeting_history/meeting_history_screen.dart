import "package:flutter/material.dart";
import "package:getteacher/net/meeting_history/meeting_history_net_model.dart";
import "package:getteacher/net/meeting_history/meetings_history.dart";
import "package:getteacher/net/net.dart";
import "package:getteacher/net/profile/profile_net_model.dart";

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

  late final Future<MeetingsHistoryNetModelRequst> respond = getMeetingsHistory(
    MeetingsHistoryNetModelRespons(
        isStudent: profile.isStudent, isTeacher: profile.isTeacher),
  );

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("History"),
          centerTitle: true,
        ),
        body: FutureBuilder<MeetingsHistoryNetModelRequst>(
          future: respond,
          builder: (
            final BuildContext context,
            final AsyncSnapshot<MeetingsHistoryNetModelRequst> snapshot,
          ) =>
              snapshot.mapSnapshot(
            onSuccess: (final MeetingsHistoryNetModelRequst response) => Center(
              child: Column(
                children: response.history
                    .map(
                      (final MeetingHistoryNetModelRequst h) => Row(
                        children: <Widget>[
                          Text(
                            h.subject,
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
                            "prtner name ${h.prtnerName}",
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
}
