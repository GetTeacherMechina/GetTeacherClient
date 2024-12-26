import "package:flutter/material.dart";
import "package:getteacher/views/teacher_main_screen/teacher_subject_editor_screen/teacher_subject_editor_screen.dart";

class TeacherMainScreen extends StatelessWidget {
  const TeacherMainScreen({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: const Center(
          child: Text("Hello teacher"),
        ),
        appBar: AppBar(
          title: const Text("AppBar with hamburger button"),
          leading: Builder(
            builder: (final BuildContext context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
        drawer: Drawer(
            child: Column(
          children: <Widget>[
            TextButton(
              child: const ListTile(
                leading: Text("My Subjects"),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (final BuildContext context) =>
                      const TeacherSubjectEditorScreen(),
                ),
              ),
            )
          ],
        )),
      );
}
