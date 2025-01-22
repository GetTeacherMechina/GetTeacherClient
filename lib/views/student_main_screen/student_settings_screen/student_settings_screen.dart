import "package:flutter/material.dart";
import "package:getteacher/common_widgets/searcher_widget.dart";
import "package:getteacher/net/favorite_teacher/favorite_teacher.dart";
import "package:getteacher/net/favorite_teacher/favorite_teacher_net_model.dart";

class StudentSettingsScreen extends StatefulWidget {
  const StudentSettingsScreen({super.key});

  @override
  State<StudentSettingsScreen> createState() => _StudentSettingsScreenState();
}

class _StudentSettingsScreenState extends State<StudentSettingsScreen> {
  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Student Settings"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const Text("Favorite Teachers!"),
              Expanded(
                child: SearcherWidget<TeacherNetModel>(
                  fetchItems: () async =>
                      (await getFavoriteTeachers()).favouriteTeachers,
                  itemBuilder: (
                    final BuildContext context,
                    final TeacherNetModel teacher,
                  ) =>
                      ExpansionTile(
                    title: Text(teacher.fullName),
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(child: Text(teacher.bio)),
                          IconButton(
                            color: Colors.red,
                            onPressed: () async {
                              await removeFavoriteTeacher(
                                FavouriteTeacherRequestModel(
                                  teacherUserId: teacher.dbUser.id,
                                ),
                              );
                              setState(() {});
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
