import "package:getteacher/net/net.dart";
import "package:getteacher/net/report_techer/report_teacher_net_model.dart";

Future<void> report(final ReportTeacherRequest model) async {
  await getClient().postJson("/report-teacher", model.toJson());
}
