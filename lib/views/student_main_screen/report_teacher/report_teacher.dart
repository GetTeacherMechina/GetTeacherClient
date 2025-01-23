import "package:flutter/material.dart";
import "package:getteacher/common_widgets/submit_button.dart";
import "package:getteacher/net/report_techer/report.dart";
import "package:getteacher/net/report_techer/report_teacher_net_model.dart";
import "package:getteacher/views/student_main_screen/report_teacher/report_teacher_model.dart";

class ReportTeacher extends StatefulWidget {
  ReportTeacher({super.key, required this.meetingGuid});

  @override
  State<StatefulWidget> createState() =>
      _ReportTeacher(meetingGuid: meetingGuid);
  final String meetingGuid;
}

class _ReportTeacher extends State<ReportTeacher> {
  _ReportTeacher({required this.meetingGuid});
  ReportTeacherModel model = const ReportTeacherModel();

  final String meetingGuid;

  late final TextEditingController reportTextEditingController =
      TextEditingController(text: model.report);

  @override
  Widget build(final BuildContext context) => AlertDialog(
        title: const Text("report techer"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: reportTextEditingController,
              decoration: const InputDecoration(
                hintText: "Report",
              ),
              onChanged: (final String value) {
                setState(() {
                  model = model.copyWith(
                    report: () => value,
                  );
                });
              },
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () async => Navigator.pop(context),
            ),
            SubmitButton(
              validate: () => true,
              submit: () async {
                await report(
                  ReportTeacherRequest(
                    reportContent: model.report,
                    meetingGuid: meetingGuid,
                  ),
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
}
