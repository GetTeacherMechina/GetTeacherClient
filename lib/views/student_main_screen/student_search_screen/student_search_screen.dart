import "package:flutter/material.dart";
import "package:getteacher/common_widgets/searcher_widget.dart";
import "package:getteacher/net/call/call_model.dart";
import "package:getteacher/net/call_teacher/call_teacher.dart";
import "package:getteacher/net/profile/profile_net_model.dart";
import "package:getteacher/net/subject_search/subject_search.dart";
import "package:getteacher/net/web_socket_json_listener.dart";
import "package:getteacher/views/call_screen.dart";

class StudentSearchWidget extends StatefulWidget {
  const StudentSearchWidget({super.key, required this.profile});
  final ProfileResponseModel profile;

  @override
  State<StudentSearchWidget> createState() => _StudentSearchWidgetState();
}

class _StudentSearchWidgetState extends State<StudentSearchWidget> {
  WebSocketJson? webSocketJson;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    WebSocketJson.connect((final Map<String, dynamic> json) {
      final CallModel callModel = CallModel.fromJson(json);
      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (final BuildContext context) =>
                CallScreen(message: callModel),
          ),
        );
      }
    }).then((final WebSocketJson ws) {
      webSocketJson = ws;
    });
  }

  Future<List<String>> fetchSubjectsFromApi() async {
    final List<String> results = await subjectSearch();
    return results;
  }

  @override
  Widget build(final BuildContext context) => Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: SearcherWidget<String>(
              fetchItems: fetchSubjectsFromApi(),
              itemBuilder: (final BuildContext context, final String item) =>
                  Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  onTap: () {
                    callTeacher(item);
                  },
                  leading: const Icon(Icons.book),
                  title: Text(item),
                ),
              ),
              hintText: "Search for subjects...",
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              await callTeacher(controller.text);
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.call),
                SizedBox(width: 10),
                Text("Call a teacher"),
              ],
            ),
          ),
        ],
      );
}
