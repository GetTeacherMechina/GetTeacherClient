import "package:flutter/material.dart";
import "package:getteacher/common_widgets/searcher_widget.dart";
import "package:getteacher/net/teacher_subjects/teacher_subjects.dart";
import "package:getteacher/net/teacher_subjects/teacher_subjects_models.dart";
import "package:getteacher/theme/theme.dart";

class SubjectEditor extends StatefulWidget {
  const SubjectEditor({super.key});

  @override
  State<SubjectEditor> createState() => _SubjectEditorState();
}

class _SubjectEditorState extends State<SubjectEditor> {
  final TextEditingController _subjectSearchEditingController =
      TextEditingController();

  Future<List<TeacherSubjectsModel>> _getTeacherFuture =
      getTeacherSubjectSelector();

  List<TeacherSubjectsModel> removed = <TeacherSubjectsModel>[];
  @override
  Widget build(final BuildContext context) => Stack(
        children: <Widget>[
          SearcherWidget<TeacherSubjectsModel>(
            searchController: _subjectSearchEditingController,
            fetchItems: () => _getTeacherFuture.then(
              (final List<TeacherSubjectsModel> items) => items
                  .where(
                    (final TeacherSubjectsModel item) =>
                        !removed.contains(item),
                  )
                  .toList(),
            ),
            itemBuilder: (
              final BuildContext context,
              final TeacherSubjectsModel item,
            ) =>
                ListTile(
              title: Text(item.toString()),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () async {
                  setState(() {
                    removed.add(item);
                  });
                  await removeTeacherSubject(
                    item.subject.name,
                    item.grade.name,
                  );
                  setState(() {
                    removed.remove(item);
                  });
                  final Future<List<TeacherSubjectsModel>> f =
                      getTeacherSubjectSelector();
                  setState(() {
                    _getTeacherFuture = f;
                  });
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (final BuildContext context) => AddSubjectDialog(
                    input: _subjectSearchEditingController.text,
                  ),
                );
                final Future<List<TeacherSubjectsModel>> f =
                    getTeacherSubjectSelector();
                setState(
                  () {
                    _getTeacherFuture = f;
                  },
                );
              },
              icon: const Icon(Icons.add),
            ),
          ),
        ],
      );
}

class AddSubjectDialog extends StatefulWidget {
  AddSubjectDialog({super.key, final String? input}) {
    if (input != null) {
      subjectTextEditingController.text = input;
    }
  }

  final TextEditingController subjectTextEditingController =
      TextEditingController();
  @override
  State<AddSubjectDialog> createState() => _AddSubjectDialogState();
}

class _AddSubjectDialogState extends State<AddSubjectDialog> {
  final List<String> grades = <String>[
    "א",
    "ב",
    "ג",
    "ד",
    "ה",
    "ו",
    "ז",
    "ח",
    "ט",
    "י",
    "יא",
    "יב",
  ];

  RangeValues gradeRange = const RangeValues(0, 11);

  @override
  Widget build(final BuildContext context) => AlertDialog(
        content: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Add Subject",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 250,
                child: TextField(
                  controller: widget.subjectTextEditingController,
                  decoration: const InputDecoration(
                    labelText: "Subject Name",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Select Grade:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              RangeSlider(
                activeColor: AppTheme.accentColor,
                values: gradeRange,
                min: 0,
                max: 11,
                divisions: 12,
                labels: RangeLabels(
                  grades[gradeRange.start.toInt()],
                  grades[gradeRange.end.toInt()],
                ),
                onChanged: (final RangeValues r) {
                  setState(() {
                    gradeRange = r;
                  });
                },
              ),
              // DropdownButton<String>(
              //   isExpanded: true,
              //   value: selectedGrade,
              //   hint: const Text("Choose a grade"),
              //   items: grades
              //       .map(
              //         (final String grade) => DropdownMenuItem<String>(
              //           value: grade,
              //           child: Text(grade),
              //         ),
              //       )
              //       .toList(),
              //   onChanged: (final String? value) {
              //     setState(() {
              //       selectedGrade = value;
              //     });
              //   },
              // ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.deepPurple, // Change button background color
                      foregroundColor: Colors.white, // Change text/icon color
                      shadowColor:
                          Colors.deepPurpleAccent, // Change shadow color
                      elevation: 5, // Adjust shadow elevation
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ), // Adjust padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // Add rounded corners
                      ),
                    ),
                    onPressed: () async {
                      if (widget.subjectTextEditingController.text.isEmpty) {
                        return;
                      }
                      await addTeacherSubjects(
                        widget.subjectTextEditingController.text,
                        grades.sublist(
                          gradeRange.start.toInt(),
                          gradeRange.end.toInt() + 1,
                        ),
                      );
                    },
                    child: const Text("Add"),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
