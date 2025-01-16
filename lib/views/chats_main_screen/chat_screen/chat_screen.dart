import "package:flutter/material.dart";

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key,required this.chatId});

  final int chatId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {


  List<String> messages =[];

  @override
  void initState() {
    super.initState();

    updateMessages();
  }

  Future<void> updateMessages() async {
    
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (final BuildContext context, final int index) => Container(),
        ),
      );
}
