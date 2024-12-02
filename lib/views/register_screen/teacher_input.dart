import "package:flutter/material.dart";
import "package:getteacher/views/register_screen/register_model.dart";

class TeacherInput extends StatelessWidget {
  TeacherInput({super.key, required this.onChanged});

  final void Function(Teacher) onChanged;

  @override
  Widget build(final BuildContext context) => TextField(
        decoration: const InputDecoration(hintText: "Bio"),
        minLines: 4,
        maxLines: 7,
        onChanged: (final String bio) => onChanged(Teacher(bio)),
      );
}
