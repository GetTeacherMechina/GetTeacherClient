import "package:flutter/material.dart";
import "package:getteacher/common_widgets/searcher_widget.dart";
import "package:getteacher/net/teacher_subjects/teacher_subjects_models.dart";
import "package:getteacher/net/teacher_subjects/teacher_subjects.dart";

class TeacherSubjectEditorScreen extends StatefulWidget {
  const TeacherSubjectEditorScreen({super.key});

  @override
  State<TeacherSubjectEditorScreen> createState() =>
      _TeacherSubjectEditorScreenState();
}

class _TeacherSubjectEditorScreenState
    extends State<TeacherSubjectEditorScreen> {
  final TextEditingController _subjectSearchEditingController =
      TextEditingController();

  Future<List<TeacherSubjectsModel>> _getTeacherFuture =
      getTeacherSubjectSelector();
  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("teacher subject selector"),
        ),
        body: SearcherWidget<TeacherSubjectsModel>(
          searchController: _subjectSearchEditingController,
          fetchItems: () => _getTeacherFuture,
          itemBuilder:
              (final BuildContext context, final TeacherSubjectsModel item) =>
                  ListTile(
            title: Text(
              "subject: ${item.subject.name}, grade: ${item.grade.name}",
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () async {
                await removeTeacherSubject(item.subject.name, item.grade.name);
                final Future<List<TeacherSubjectsModel>> f =
                    getTeacherSubjectSelector();
                setState(() {
                  _getTeacherFuture = f;
                });
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final (String, String)? data = await showDialog<(String, String)>(
              context: context,
              builder: (final BuildContext context) => AddSubjectDialog(
                input: _subjectSearchEditingController.text,
              ),
            );
            if (data != null) {
              final (String subject, String grade) = data;
              await addTeacherSubject(subject, grade);
            }
            final Future<List<TeacherSubjectsModel>> f =
                getTeacherSubjectSelector();
            setState(
              () {
                _getTeacherFuture = f;
              },
            );
          },
          child: const Icon(Icons.add),
        ),
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

  String? selectedGrade;

  @override
  Widget build(final BuildContext context) => Dialog(
        child: Padding(
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
              DropdownButton<String>(
                isExpanded: true,
                value: selectedGrade,
                hint: const Text("Choose a grade"),
                items: grades
                    .map(
                      (final String grade) => DropdownMenuItem<String>(
                        value: grade,
                        child: Text(grade),
                      ),
                    )
                    .toList(),
                onChanged: (final String? value) {
                  setState(() {
                    selectedGrade = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (widget.subjectTextEditingController.text.isEmpty ||
                          selectedGrade == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please fill all fields."),
                          ),
                        );
                        return;
                      }
                      // Return the input and selected grade
                      Navigator.pop(
                        context,
                        (
                          widget.subjectTextEditingController.text,
                          selectedGrade!,
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
