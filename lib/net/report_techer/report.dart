import "package:getteacher/net/net.dart";
import "package:getteacher/net/report_techer/report_teacher_net_model.dart";

Future<void> report (final ReportTeacherNetModel model) async {
  await getClient().postJson("TODO", model.toJson()); // TODO endpoint
}