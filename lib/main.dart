import "package:flutter/material.dart";
import "package:getteacher/views/register_screen/register_screen.dart";
import "package:getteacher/views/teacher_subject_selctor_screen/teacher_subject_selctor_screen.dart";

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(final BuildContext context) => MaterialApp(
        home: TeacherSubjectSelctor(),//home: RegisterScreen(),
      );
}
