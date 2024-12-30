import "package:flutter/material.dart";
import "package:getteacher/net/profile/profile.dart";
import "package:getteacher/net/profile/profile_net_model.dart";
import "package:getteacher/views/student_main_screen/student_main_screen.dart";
import "package:getteacher/views/teacher_main_screen/teacher_main_screen.dart";
import "package:getteacher/views/teacher_student_selection_screen/teacher_student_selection_screen.dart";

Future<Widget> getMainScreen() async {
  final ProfileResponseModel profileResponseModel = await profile();
  return switch ((
    profileResponseModel.isStudent,
    profileResponseModel.isTeacher
  )) {
    (true, true) => TeacherStudentSelection(
        profile: profileResponseModel,
      ),
    (true, false) => StudentMainScreen(
        profile: profileResponseModel,
      ),
    (false, true) => TeacherMainScreen(
        profile: profileResponseModel,
      ),
    (false, false) => throw Exception("Impossible")
  };
}
