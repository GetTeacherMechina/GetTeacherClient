import "package:flutter/material.dart";
import "package:getteacher/views/register_screen/register_model.dart";
import "package:getteacher/views/register_screen/student_input.dart";
import "package:getteacher/views/register_screen/teacher_input.dart";

class UserRoleInput extends StatelessWidget {
  const UserRoleInput({
    super.key,
    required this.role,
    required this.onRoleChanged,
  });
  final UserRole role;
  final void Function(UserRole) onRoleChanged;

  @override
  Widget build(final BuildContext context) => Column(
        children: <Widget>[
          switch (role) {
            Teacher() => TeacherInput(onChanged: onRoleChanged),
            Student() => StudentInput(
                student: role as Student,
                onChanged: onRoleChanged,
              ),
            StudentAndTeacher() => throw UnimplementedError(),
          },
        ],
      );
}
