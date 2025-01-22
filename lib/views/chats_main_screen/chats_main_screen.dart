import "package:flutter/material.dart";
import "package:getteacher/common_widgets/searcher_widget.dart";
import "package:getteacher/net/chats/chats.dart";
import "package:getteacher/net/chats/get_chats_model.dart";
import "package:getteacher/net/net.dart";
import "package:getteacher/net/profile/profile.dart";
import "package:getteacher/net/profile/profile_net_model.dart";
import "package:getteacher/net/web_socket_json_listener.dart";
import "package:getteacher/views/chats_main_screen/chat_screen/chat_screen.dart";
import "package:getteacher/views/chats_main_screen/create_chat_screen/create_chat_screen.dart";

class ChatsMainScreen extends StatefulWidget {
  const ChatsMainScreen({super.key, required this.webSocketJson});

  final WebSocketJson webSocketJson;
  @override
  State<ChatsMainScreen> createState() => _ChatsMainScreenState();
}

class _ChatsMainScreenState extends State<ChatsMainScreen> {
  bool noneFlag = false;

  @override
  void didUpdateWidget(final ChatsMainScreen state) {
    super.didUpdateWidget(state);
    setState(() {});
    print("???");
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Chats"),
        ),
        body: SearcherWidget<ChatEntryModel>(
          fetchItems: () async {
            final ChatsModel data = await getChats();
            return data.chats;
          },
          itemBuilder: (final BuildContext ctx, final ChatEntryModel item) =>
              ListTile(
            onTap: () async {
              final ProfileResponseModel prof = await profile();
              await Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (final BuildContext context) => ChatScreen(
                    chatId: item.id,
                    webSocketJson: widget.webSocketJson,
                    profile: prof,
                  ),
                ),
              );
            },
            title: Text(
              item.users.map((final ChatUserModel a) => a.username).join(", "),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => CreateChatScreen(),
              ),
            );
            setState(() {});
          },
        ),
      );
}
