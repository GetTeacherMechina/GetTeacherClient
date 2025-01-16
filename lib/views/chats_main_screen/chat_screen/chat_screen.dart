import "package:flutter/material.dart";
import "package:getteacher/common_widgets/searcher_widget.dart";

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
          itemBuilder: (final BuildContext context, final int index) =>
              Container(),
        ),
      );
}
