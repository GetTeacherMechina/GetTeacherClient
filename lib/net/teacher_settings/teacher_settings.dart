import "package:getteacher/net/net.dart";
import "package:getteacher/net/teacher_settings/teacher_settings_model.dart";

Future<TeacherSettingsModel> getTeacherSettings() async {
  final Map<String, dynamic> json =
      await getClient().getJson("/teacher/settings");

  return TeacherSettingsModel.fromJson(json);
}

Future<void> setBio(final String bio) async {
  await getClient()
      .postJson("/teacher/settings/bio", <String, String>{"Bio": bio});
}

Future<void> setCreditTarif(final double creditTarif) async {
  await getClient().postJson(
    "/teacher/settings/tariff",
    <String, double>{"creditsTariffPerMinute": creditTarif},
  );
}
