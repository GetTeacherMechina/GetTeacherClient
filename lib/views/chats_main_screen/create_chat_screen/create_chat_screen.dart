import "package:flutter/material.dart";
import "package:getteacher/net/chats/chats.dart";
import "package:getteacher/net/users/users.dart";

class CreateChatScreen extends StatefulWidget {
  const CreateChatScreen({super.key});

  @override
  State<CreateChatScreen> createState() => _CreateChatScreenState();
}

class _CreateChatScreenState extends State<CreateChatScreen> {
  List<(UserData, bool)> teachers = [];

  Future<void> onCreateChat() async {
    final List<int> list = teachers
        .where((final (UserData, bool) a) => a.$2)
        .map((final (UserData, bool) a) => a.$1.id)
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
    getAllUsers().then(
      (final List<UserData> v) => setState(() {
        teachers = v.map((final UserData a) => (a, false)).toList();
      }),
    );
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Create Chat - Select Teachers"),
        ),
        body: ListView.builder(
          itemCount: teachers.length,
          itemBuilder: (final BuildContext context, final int index) =>
              ListTile(
            title: Text(teachers[index].$1.userName),
            leading: Checkbox(
              value: teachers[index].$2,
              onChanged: (final bool? value) {
                setState(() {
                  teachers[index] = (teachers[index].$1, !teachers[index].$2);
                });
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            onCreateChat();
          },
          child: const Icon(Icons.create),
        ),
      );
}
