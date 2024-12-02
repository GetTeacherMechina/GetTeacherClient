import "package:flutter/material.dart";
import "package:getteacher/views/register_screen/register_model.dart";

class StudentInput extends StatelessWidget {
  const StudentInput({
    super.key,
    required this.student,
    required this.onChanged,
  });

  final Student student;
  final void Function(Student) onChanged;

  @override
  Widget build(final BuildContext context) => const Placeholder(
        child: Text("Student input todo grades"),
      );
}
