import "dart:typed_data";

import "package:file_picker/file_picker.dart";
import "package:flutter/material.dart";
import "package:getteacher/common_widgets/latex_text_widget.dart";
import "package:getteacher/net/chats/chats.dart";
import "package:getteacher/net/chats/get_chat_model.dart";
import "package:getteacher/net/chats/message_model.dart";
import "package:getteacher/net/net.dart";
import "package:getteacher/net/profile/profile_net_model.dart";
import "package:getteacher/net/web_socket_json_listener.dart";
import "package:getteacher/theme/theme.dart";
import "package:getteacher/views/chats_main_screen/chat_screen/image_displayer.dart";

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
  ScrollController scrollController = ScrollController();

  void handleNewMessage(final Map<String, dynamic> json) {
    final MessageModel msg = MessageModel.fromJson(json);
    setState(() {
      messages.add(msg);
    });
    jumpBottomNextFrame();
  }

  void webSocketHandler(final Map<String, dynamic> json) async {
    if (json[messageType] == "chat_message") {
      handleNewMessage(json);
    }
  }

  void jumpBottomNextFrame() {
    WidgetsBinding.instance.addPostFrameCallback(
      (final _) =>
          scrollController.jumpTo(scrollController.position.maxScrollExtent),
    );
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
      messages = chat.messages ?? <MessageModel>[];
    });
    jumpBottomNextFrame();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Chat"),
          backgroundColor: AppTheme.primaryColor,
        ),
        backgroundColor: AppTheme.backgroundColor,
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: messages.length,
                itemBuilder: (final BuildContext context, final int index) {
                  final MessageModel message = messages[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: message.senderId == widget.profile.id
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: message.senderId == widget.profile.id
                              ? AppTheme.accentColor
                              : Colors.blueAccent,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [AppTheme.defaultShadow],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              message.senderName,
                              style: AppTheme.secondaryHeadingStyle.copyWith(
                                fontSize: 18,
                                color: AppTheme.whiteColor,
                              ),
                            ),
                            (message.content.startsWith("####") &&
                                    message.content.endsWith("####") &&
                                    message.content.length > 8)
                                ? ImageDisplayer(
                                    url: message.content.replaceAll("####", ""),
                                  )
                                : LatexTextWidget(
                                    text: message.content,
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
                      maxLines: null, // Allows unlimited lines
                      keyboardType: TextInputType.multiline,
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        hintStyle: AppTheme.bodyTextStyle.copyWith(
                          color: AppTheme.hintTextColor,
                        ),
                        filled: true,
                        fillColor: AppTheme.inputFieldBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: AppTheme.borderColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final FilePickerResult? result = await FilePicker.platform
                          .pickFiles(type: FileType.any, allowMultiple: false);

                      if (result != null) {
                        final Uint8List? fileBytes = result.files.first.bytes;
                        if (fileBytes != null) {
                          final Map<String, dynamic> x =
                              await getClient().postImage("/images", fileBytes);
                          await createMessage(
                              widget.chatId, "####${x["url"]}####");
                          final MessageModel msg = MessageModel(
                            id: -1,
                            senderId: widget.profile.id,
                            content: "####${x["url"]}####",
                            dateTime: DateTime.now(),
                            senderName: widget.profile.fullName,
                          );
                          setState(() {
                            messages.add(msg);
                          });
                        }
                      }
                    },
                    icon: const Icon(Icons.image),
                    color: AppTheme.primaryColor,
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    color: AppTheme.primaryColor,
                    onPressed: () async {
                      await createMessage(widget.chatId, controller.text);
                      final MessageModel msg = MessageModel(
                        id: -1,
                        senderId: widget.profile.id,
                        content: controller.text,
                        dateTime: DateTime.now(),
                        senderName: widget.profile.fullName,
                      );

                      setState(() {
                        messages.add(msg);
                        controller.clear();
                        jumpBottomNextFrame();
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
