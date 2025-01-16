import "package:getteacher/net/chats/chat_creation_model.dart";
import "package:getteacher/net/chats/message_creation_model.dart";
import "package:getteacher/net/net.dart";

Future<void> createChat(final List<int> users) async {
  await getClient()
      .postJson("/chats/create", ChatCreationModel(users: users).toJson());
}

Future<void> createMessage(final int chatId, final String content) async {
  await getClient()
      .postJson("/chats/send-message/$chatId", MessageCreationModel(content: content).toJson());
}
