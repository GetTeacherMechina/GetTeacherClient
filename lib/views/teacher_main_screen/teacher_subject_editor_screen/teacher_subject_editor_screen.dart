import "package:flutter/material.dart";
import "package:getteacher/common_widgets/searcher_widget.dart";
import "package:getteacher/net/teacher_subject_selector/teacher_subject_selector.dart";
import "package:getteacher/net/teacher_subject_selector/teacher_subject_selector_handler.dart";

class TeacherSubjectEditorScreen extends StatefulWidget {
  const TeacherSubjectEditorScreen({super.key});

  @override
  State<TeacherSubjectEditorScreen> createState() =>
      _TeacherSubjectEditorScreenState();
}

class _TeacherSubjectEditorScreenState
    extends State<TeacherSubjectEditorScreen> {
  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("teacher subject selector"),
        ),
        body: SearcherWidget<TeacherSubjectModel>(
          fetchItems: getTeacherSubjectSelector,
          itemBuilder:
              (final BuildContext context, final TeacherSubjectModel item) =>
                  ListTile(
            title: Text("subject: ${item.subject}, grade: ${item.grade}"),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog<String>(
              context: context,
              builder: (final BuildContext context) => AddSubjectDialog(),
            );
          },
          child: const Icon(Icons.add),
        ),
      );
}

class AddSubjectDialog extends StatelessWidget {
  AddSubjectDialog({
    super.key,
  });

  final TextEditingController subjectTextEditingController =
      TextEditingController();
  @override
  Widget build(final BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Add Subject",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 250,
                child: TextField(
                  controller: subjectTextEditingController,
                  decoration: const InputDecoration(
                    labelText: "Subject Name",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Handle Add action
                      Navigator.pop(context, subjectTextEditingController.text);
                    },
                    child: const Text("Add"),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
