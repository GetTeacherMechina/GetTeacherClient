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
        children: <Widget>[
          Slider(
            value: student.grade.toDouble(),
            max: 12,
            min: 1,
            divisions: 11,
            label: student.grade.toString(),
            onChanged: (final double value) {
              onChanged(Student(value.toInt()));
            },
          ),
          Text(grades[student.grade]!, style: const TextStyle(fontSize: 40)),
        ],
      );
}
