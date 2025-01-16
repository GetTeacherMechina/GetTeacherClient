import "package:flutter/material.dart";
import "package:getteacher/common_widgets/searcher_widget.dart";

class ChatsMainScreen extends StatefulWidget {
  const ChatsMainScreen({super.key});

  @override
  State<ChatsMainScreen> createState() => _ChatsMainScreenState();
}

class _ChatsMainScreenState extends State<ChatsMainScreen> {
  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Chats"),
        ),
        body: SearcherWidget<()>(
            fetchItems: () async => [],
            itemBuilder: (ctx, item) => Container()),
      );
}
