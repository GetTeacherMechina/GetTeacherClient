import "dart:async";

import "package:flutter/material.dart";
import "package:getteacher/net/login/login_net_model.dart";
import "package:getteacher/net/net.dart";
import "package:getteacher/net/profile/profile.dart";
import "package:getteacher/net/profile/profile_net_model.dart";
import "package:getteacher/views/student_main_screen/student_main_screen.dart";
import "package:getteacher/views/teacher_main_screen/teacher_main_screen.dart";
import "package:getteacher/views/teacher_student_selection_screen/teacher_student_selection_screen.dart";

Future<void> login(
  final LoginRequestModel request,
  final BuildContext context,
) async {
  final Map<String, dynamic> response =
      await getClient().postJson("/auth/login", request.toJson());

  final LoginResponseModel jwt = LoginResponseModel.fromJson(response);
  getClient().authorize(jwt.jwtToken);

  final ProfileResponseModel profileResponseModel = await profile();

  unawaited(
    Navigator.of(context).pushReplacement(
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
    ),
  );
}
