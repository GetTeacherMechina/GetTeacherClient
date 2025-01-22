import "package:flutter/material.dart";
import "package:getteacher/views/register_screen/register_model.dart";

class TeacherInput extends StatelessWidget {
  TeacherInput({super.key, required this.onChanged, required this.teacher});
  final Teacher teacher;
  final void Function(Teacher) onChanged;

  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
              borderRadius: BorderRadius.circular(15),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: TextFormField(
              initialValue: teacher.bio,
              decoration: InputDecoration(
                hintText: "Tell Us About Yourself\nWrite a short bio about your teaching experience...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                filled: true,
                fillColor: Colors.blueGrey[50],
              ),
              minLines: 3,
              maxLines: 8,
              onChanged: (final String bio) => onChanged(Teacher(bio)),
            ),
          ),
        ],
      );
}
