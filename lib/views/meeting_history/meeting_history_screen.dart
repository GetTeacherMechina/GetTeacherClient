import "package:flutter/material.dart";
import "package:getteacher/net/meeting_history/meeting_history_net_model.dart";
import "package:getteacher/net/meeting_history/meetings_history.dart";
import "package:getteacher/net/net.dart";

class MeetingHistoryScreen extends StatefulWidget {
  MeetingHistoryScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MeetingHistoryScreen();
}

class _MeetingHistoryScreen extends State<MeetingHistoryScreen> {

  final Future<MeetingsHistoryNetModel> respond = getMeetingsHistory();
  
  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("History"), centerTitle: true,),
    body: FutureBuilder<MeetingsHistoryNetModel>(
      future: respond,
      builder: (
        final BuildContext context,
        final AsyncSnapshot<MeetingsHistoryNetModel> snapshot,
      ) => snapshot.mapSnapshot(
        onSuccess: (final MeetingsHistoryNetModel response) => Center(
          child: Column(
            children: response.history.map(
              (final MeetingHistoryNetModel h) => Row(
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
            ).toList(),
          ),
        ),
      ),
    ),
  );

}