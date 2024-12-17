import "package:getteacher/net/net.dart";
import "package:getteacher/net/profile/profile_net_model.dart";

Future<ProfileResponseModel> profile() async {
  final json = await getClient().getJson("/profile");
  print(json);
  return ProfileResponseModel.fromJson(json);
}
