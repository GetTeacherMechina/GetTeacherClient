
import "package:flutter/material.dart";
import "package:getteacher/common_widgets/submit_button.dart";
import "package:getteacher/net/report_techer/report.dart";
import "package:getteacher/net/report_techer/report_teacher_net_model.dart";
import "package:getteacher/views/student_main_screen/report_techer/report_teacher_model.dart";

class ReportTecher extends StatefulWidget {
  ReportTecher({super.key});

  @override
  State<StatefulWidget> createState() => _ReportTecher();
}

class _ReportTecher extends State<ReportTecher> {
  ReportTeacherModel model = const ReportTeacherModel();

  late final TextEditingController reportTextEditingController =
    TextEditingController(text: model.report);

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(final BuildContext context) => AlertDialog(
      title: const Text("report techer"),
      content: Column(
        key: _formKey,
        children: <Widget>[
          TextField(
            controller: reportTextEditingController,
            decoration: const InputDecoration(
              hintText: "report",
            ),
            onChanged: (final String value) => {
              model.copyWith(report: () => value,),
            },
          ),
          TextButton(
            child: const Text("Cancel"),
            onPressed: () async => Navigator.pop(context),
          ),
          SubmitButton(
            validate: () => _formKey.currentState!.validate(),
            submit: () async {
              await report(ReportTeacherNetModel(report: model.report));
              Navigator.pop(context);
            },
          ),
        ],
      ),
  );

}