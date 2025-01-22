import "package:flutter/material.dart";
import "package:getteacher/net/chats/chats.dart";
import "package:getteacher/net/chats/get_chat_model.dart";
import "package:getteacher/net/chats/message_model.dart";
import "package:getteacher/net/profile/profile_net_model.dart";
import "package:getteacher/net/web_socket_json_listener.dart";

const String messageType = "MessageType";

class ChatScreen extends StatefulWidget {
  ChatScreen({
    super.key,
    required this.chatId,
    required this.webSocketJson,
    required this.profile,
  });

  final int chatId;
  final WebSocketJson webSocketJson;
  final ProfileResponseModel profile;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<MessageModel> messages = <MessageModel>[];
  final TextEditingController controller = TextEditingController();

  void handleNewMessage(final Map<String, dynamic> json) {
    final MessageModel msg = MessageModel.fromJson(json);

    setState(() {
      messages.add(msg);
    });
  }

  void webSocketHandler(final Map<String, dynamic> json) async {
    if (json[messageType] == "chat_message") {
      handleNewMessage(json);
    }
  }

  @override
  void initState() {
    super.initState();

    widget.webSocketJson.addNewListener(webSocketHandler);

    updateMessages();
  }

  @override
  void dispose() {
    super.dispose();

    widget.webSocketJson.removeListener(webSocketHandler);
  }

  Future<void> updateMessages() async {
    final ChatModel chat = await getChat(widget.chatId);

    setState(() {
      messages = chat.messages;
    });
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Chat"),
          backgroundColor: Colors.blueAccent,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (final BuildContext context, final int index) {
                  final MessageModel message = messages[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              message.senderName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              message.content,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    color: Colors.blueAccent,
                    onPressed: () async {
                      await createMessage(widget.chatId, controller.text);
                      final MessageModel msg = MessageModel(
                        id: -1,
                        senderId: -1,
                        content: controller.text,
                        dateTime: DateTime.now(),
                        senderName: widget.profile.fullName,
                      );

                      setState(() {
                        messages.add(msg);
                        controller.clear();
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
