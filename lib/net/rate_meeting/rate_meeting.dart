import "package:getteacher/net/net.dart";
import "package:getteacher/net/rate_meeting/rate_meeting_net_model.dart";

Future<void> rateMeeting(final RateMeetingRequestModel model) async {
  await getClient().postJson("/meeting/info/rate", model.toJson());
  if (model.favoriteTeacher)
    await getClient().postJson("/meeting/favorite-teacher", model.toJson());
}
