import "package:flutter/material.dart";
import "package:getteacher/common_widgets/searcher_widget.dart";
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
        body: SearcherWidget<(UserDetails, bool)>(
          getItemString: (final (UserDetails, bool) p0) => p0.$1.user.userName,
          fetchItems: () async => users,
          itemBuilder: (
            final BuildContext context,
            final (UserDetails, bool) userDetails,
          ) =>
              ListTile(
            title: Text(userDetails.$1.user.userName),
            leading: Checkbox(
              value: userDetails.$2,
              onChanged: (final _) {
                setState(() {
                  users[users.indexOf(userDetails)] =
                      (userDetails.$1, !userDetails.$2);
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
