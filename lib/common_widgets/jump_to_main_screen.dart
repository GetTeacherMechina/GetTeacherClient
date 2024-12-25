import "package:flutter/material.dart";
import "package:getteacher/net/profile/profile.dart";
import "package:getteacher/net/profile/profile_net_model.dart";
import "package:getteacher/views/student_main_screen/student_main_screen.dart";
import "package:getteacher/views/teacher_main_screen/teacher_main_screen.dart";
import "package:getteacher/views/teacher_student_selection_screen/teacher_student_selection_screen.dart";

Future<void> jumpToMainScreen(final BuildContext context) async {
  final ProfileResponseModel profileResponseModel = await profile();
  await Navigator.of(context).pushReplacement(
    MaterialPageRoute<void>(
      builder: (final BuildContext context) => switch ((
        profileResponseModel.isStudent,
        profileResponseModel.isTeacher
      )) {
        (true, true) => const TeacherStudentSelection(),
        (true, false) => const StudentMainScreen(),
        (false, true) => const TeacherMainScreen(),
        (false, false) => throw Exception("Impossible")
      },
    ),
  );
}
