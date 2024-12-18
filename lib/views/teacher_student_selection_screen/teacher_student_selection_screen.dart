import "package:flutter/material.dart";
import "package:getteacher/views/student_main_screen/student_main_screen.dart";
import "package:getteacher/views/teacher_main_screen/teacher_main_screen.dart";

class TeacherStudentSelection extends StatefulWidget {
  const TeacherStudentSelection({super.key});

  @override
  State<TeacherStudentSelection> createState() =>
      _TeacherStudentSelectionState();
}

class _TeacherStudentSelectionState extends State<TeacherStudentSelection> {
  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Center(
          child: Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (final BuildContext context) =>
                          const TeacherMainScreen(),
                    ),
                  );
                },
                child: const Text("Teacher"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (final BuildContext context) =>
                          const StudentMainScreen(),
                    ),
                  );
                },
                child: const Text("Student"),
              ),
            ],
          ),
        ),
      );
}
