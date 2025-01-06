import "package:flutter/material.dart";
import "package:getteacher/net/call/student_call_model.dart";

class ApproveTeacher extends StatelessWidget {
  const ApproveTeacher(this.call);

  final StudentCallModel call;

  @override
  Widget build(final BuildContext context) => AlertDialog(
        title: Text(
          "You can chat with ${call.meetingResponse.companionName}",
        ),
        content: Column(
          children: [Text(call.teacherBio), Text("Rated: ${call.teacherRank}")],
        ),
        actionsAlignment: MainAxisAlignment.center,
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
          )
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
