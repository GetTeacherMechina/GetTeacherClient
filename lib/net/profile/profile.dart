import "package:getteacher/net/net.dart";
import "package:getteacher/net/profile/profile_net_model.dart";

Future<ProfileResponseModel> profile() async {
  final Map<String, dynamic> json = await getClient().getJson("/profile");
  return ProfileResponseModel.fromJson(json);
}

Future<StudentProfile> studentProfile() async {
  final Map<String, dynamic> json =
      await getClient().getJson("/profile/student");
  return StudentProfile.fromJson(json);
}
