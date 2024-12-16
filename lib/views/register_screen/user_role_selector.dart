import "package:flutter/material.dart";
import "package:getteacher/views/register_screen/register_model.dart";

const int studnetIndex = 0;
const int teacherIndex = 1;

class UserRoleSelector extends StatelessWidget {
  const UserRoleSelector({
    super.key,
    required this.role,
    required this.onNewUserRole,
  });
  final UserRole role;
  final void Function(UserRole) onNewUserRole;

  @override
  Widget build(final BuildContext context) => ToggleButtons(
        children: const <Widget>[
          Tooltip(message: "Teacher", child: Icon(Icons.school)),
          Tooltip(message: "Student", child: Icon(Icons.book)),
        ],
        isSelected: <bool>[
          role.isTeacher(),
          role.isStudent(),
        ],
        onPressed: (final int index) {
          onNewUserRole(
            switch (role) {
              Teacher() => index == teacherIndex
                  ? StudentAndTeacher(
                      const Student.empty(),
                      role as Teacher,
                    )
                  : role,
              Student() => index == studnetIndex
                  ? StudentAndTeacher(
                      role as Student,
                      const Teacher.empty(),
                    )
                  : role,
              StudentAndTeacher(
                student: final Student student,
                teacher: final Teacher teacher
              ) =>
                index == studnetIndex ? student : teacher
            },
          );
        },
      );
}
