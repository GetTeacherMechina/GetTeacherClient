import "package:flutter/material.dart";
import "package:getteacher/common_widgets/searcher_widget.dart";
import "package:getteacher/net/chats/chats.dart";
import "package:getteacher/net/chats/get_chats_model.dart";
import "package:getteacher/net/profile/profile.dart";
import "package:getteacher/net/profile/profile_net_model.dart";
import "package:getteacher/net/web_socket_json_listener.dart";
import "package:getteacher/theme/theme.dart";
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
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Chats"),
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: AppTheme.whiteColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SearcherWidget<ChatEntryModel>(
            fetchItems: () async {
              final ChatsModel data = await getChats();
              return data.chats;
            },
            itemBuilder: (final BuildContext ctx, final ChatEntryModel item) =>
                Card(
              elevation: 4,
              shadowColor: AppTheme.defaultShadow.color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                  item.users.join(", "),
                  style: AppTheme.bodyTextStyle
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                leading: const CircleAvatar(
                  backgroundColor: AppTheme.accentColor,
                  child: Icon(Icons.chat, color: AppTheme.whiteColor),
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Create Chat",
          backgroundColor: AppTheme.accentColor,
          child: const Icon(Icons.add, size: 28),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute<dynamic>(
                builder: (final BuildContext context) =>
                    const CreateChatScreen(),
              ),
            );
            setState(() {});
          },
        ),
      );
}
