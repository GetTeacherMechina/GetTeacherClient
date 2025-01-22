import "package:flutter/material.dart";
import "package:getteacher/common_widgets/searcher_widget.dart";
import "package:getteacher/views/chats_main_screen/create_chat_screen/create_chat_screen.dart";

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
          itemBuilder: (final BuildContext ctx, final () item) => Container(),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => CreateChatScreen(),
                ));
          },
        ),
      );
}
