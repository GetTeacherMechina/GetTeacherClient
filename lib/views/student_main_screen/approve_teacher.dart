import "package:circular_countdown_timer/circular_countdown_timer.dart";
import "package:flutter/material.dart";
import "package:getteacher/net/call/student_call_model.dart";

class ApproveTeacher extends StatelessWidget {
  const ApproveTeacher(this.call);

  final StudentCallModel call;

  @override
  Widget build(final BuildContext context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "You can chat with ${call.meetingResponse.companionName}",
            ),
            if (call.isFavorite) // Check if the teacher is a favorite
              const Icon(
                Icons.star,
                color: Colors.yellow,
              ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: CircularCountDownTimer(
                fillColor: Theme.of(context).primaryColor,
                ringColor: Theme.of(context).primaryColor.withAlpha(200),
                width: 50,
                height: 50,
                duration: 8,
                isReverse: true,
                isReverseAnimation: true,
                onComplete: () {
                  Navigator.of(context).pop(false);
                },
                autoStart: true,
              ),
            ),
            Text(call.teacherBio),
            Text("Rated: ${call.teacherRank.toStringAsFixed(2)}"),
          ],
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            icon: const Icon(Icons.check),
            color: Colors.green,
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            icon: const Icon(Icons.close),
            color: Colors.red,
          ),
        ],
      );
}

Future<bool> showApproveTeacher(
  final BuildContext context,
  final StudentCallModel call,
) async {
  final bool? approved = await showDialog<bool>(
    barrierDismissible: false,
    context: context,
    builder: (final BuildContext context) => ApproveTeacher(call),
  );
  return approved ?? false;
}
