import "package:flutter/material.dart";
import "package:getteacher/net/chats/chats.dart";
import "package:getteacher/net/users/users.dart";

class CreateChatScreen extends StatefulWidget {
  const CreateChatScreen({super.key});

  @override
  State<CreateChatScreen> createState() => _CreateChatScreenState();
}

class _CreateChatScreenState extends State<CreateChatScreen> {
  List<(UserDetails, bool)> users = <(UserDetails, bool)>[];

  Future<void> onCreateChat() async {
    final List<int> list = users
        .where((final (UserDetails, bool) a) => a.$2)
        .map((final (UserDetails, bool) a) => a.$1.user.id)
        .toList();
    if (list.isEmpty) {
      return;
    }
    await createChat(list);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    getAllUsersExcludingSelf().then(
      (final List<UserDetails> v) => setState(() {
        users = v.map((final UserDetails a) => (a, false)).toList();
      }),
    );
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Create Chat - Select Teachers"),
        ),
        body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (final BuildContext context, final int index) =>
              ListTile(
            title: Text(users[index].$1.user.userName),
            leading: Checkbox(
              value: users[index].$2,
              onChanged: (final bool? value) {
                setState(() {
                  users[index] = (users[index].$1, !users[index].$2);
                });
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: onCreateChat,
          child: const Icon(Icons.create),
        ),
      );
}
