import "package:getteacher/net/net.dart";
import "package:getteacher/net/rate_meeting/rate_meeting_net_model.dart";

Future<void> rateMeeting(final RateMeetingRequestModel model) async
{
  await getClient().postJson("/api/v1/meeting/info/rate", model.toJson());
}