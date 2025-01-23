import "package:circular_countdown_timer/circular_countdown_timer.dart";
import "package:flutter/material.dart";
import "package:getteacher/net/call/student_call_model.dart";
import "package:getteacher/theme/theme.dart";

class ApproveTeacher extends StatelessWidget {
  const ApproveTeacher(this.call);

  final StudentCallModel call;

  @override
  Widget build(final BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: AppTheme.whiteColor,
        content: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Chat with ${call.meetingResponse.companionName}",
                      style: AppTheme.matchTextStyle,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (call.isFavorite)
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 30,
                    ),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: CircularCountDownTimer(
                  fillColor: AppTheme.primaryColor,
                  ringColor: AppTheme.primaryColor.withAlpha(100),
                  width: 50,
                  height: 50,
                  duration: 8,
                  isReverse: true,
                  isReverseAnimation: true,
                  strokeWidth: 5,
                  textStyle: AppTheme.bodyTextStyle,
                  onComplete: () {
                    Navigator.of(context).pop(false);
                  },
                  autoStart: true,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "\"${call.teacherBio}\"",
                style: AppTheme.bodyTextStyle,
              ),
              const SizedBox(height: 10),
              Text(
                "Rated: ${call.teacherRank.toStringAsFixed(2)}",
                style: AppTheme.bodyTextStyle,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    icon: const Icon(Icons.check, color: Colors.white),
                    label: const Text("Accept"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    icon: const Icon(Icons.close, color: Colors.white),
                    label: const Text("Decline"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
