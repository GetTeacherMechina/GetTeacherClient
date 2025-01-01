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
            showDialog<String>(context: context, builder: (BuildContext context)=>Dialog<>(),);
          },
          child: const Icon(Icons.add),
        ),
      );
}
