import "package:flutter/material.dart";
import "package:getteacher/views/register_screen/register_model.dart";

class TeacherInput extends StatefulWidget {
  TeacherInput({super.key, required this.onChanged, required this.teacher});
  final Teacher teacher;
  final void Function(Teacher) onChanged;

  @override
  State<TeacherInput> createState() => _TeacherInputState();
}

class _TeacherInputState extends State<TeacherInput> {
  final TextEditingController controller = TextEditingController();
  @override
  void didUpdateWidget(covariant final TeacherInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (controller.text != widget.teacher.bio) {
      controller.text = widget.teacher.bio;
    }
  }

  @override
  Widget build(final BuildContext context) => TextField(
        controller: controller,
        decoration: const InputDecoration(hintText: "Bio"),
        minLines: 4,
        maxLines: 7,
        onChanged: (final String bio) => widget.onChanged(Teacher(bio)),
      );
}
