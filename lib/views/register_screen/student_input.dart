import "package:flutter/material.dart";
import "package:getteacher/views/register_screen/register_model.dart";

const Map<int, String> grades = <int, String>{
  1: "א",
  2: "ב",
  3: "ג",
  4: "ד",
  5: "ה",
  6: "ו",
  7: "ז",
  8: "ח",
  9: "ט",
  10: "י",
  11: "יא",
  12: "יב",
};

class StudentInput extends StatelessWidget {
  const StudentInput({
    super.key,
    required this.student,
    required this.onChanged,
  });

  final Student student;
  final void Function(Student) onChanged;

  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: student.grade,
                isExpanded: true,
                items: grades.entries
                    .map(
                      (final MapEntry<int, String> entry) =>
                          DropdownMenuItem<int>(
                        value: entry.key,
                        child: Text("כיתה ${entry.value}"),
                      ),
                    )
                    .toList(),
                onChanged: (final int? value) {
                  if (value != null) {
                    onChanged(Student(value));
                  }
                },
              ),
            ),
          ),
        ],
      );
}
