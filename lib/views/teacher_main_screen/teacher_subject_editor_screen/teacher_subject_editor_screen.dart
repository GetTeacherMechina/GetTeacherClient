import "package:flutter/material.dart";
import "package:getteacher/common_widgets/searcher_widget.dart";

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
        body: SearcherWidget<String>(
          fetchItems: (final String? data) async => <String>["a", "b", "c"],
          itemBuilder: (final BuildContext context, final String item) =>
              ListTile(
            title: Text(item),
          ),
        ),
      );
}
