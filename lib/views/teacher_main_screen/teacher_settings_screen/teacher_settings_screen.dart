import "package:flutter/material.dart";
import "package:getteacher/theme/theme.dart";
import "package:getteacher/theme/widgets.dart";
import "package:getteacher/views/teacher_main_screen/teacher_settings_screen/settings_editor.dart";
import "package:getteacher/views/teacher_main_screen/teacher_settings_screen/subjects_editor.dart";

class TeacherSettingsScreen extends StatefulWidget {
  const TeacherSettingsScreen({super.key});

  @override
  State<TeacherSettingsScreen> createState() => _TeacherSettingsScreenState();
}

class _TeacherSettingsScreenState extends State<TeacherSettingsScreen> {
  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("teacher subject selector"),
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: AppTheme.whiteColor,
        ),
        body: Stack(
          children: <Widget>[
            AppWidgets.homepageLogo(),
            AppWidgets.coverBubblesImage(),
            Row(
              spacing: 50,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Spacer(),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: <Widget>[
                      const Spacer(),
                      Expanded(
                        flex: 4,
                        child: Card(
                          child: SettingsEditor(),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                const Expanded(
                  flex: 3,
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Expanded(
                        flex: 4,
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: SubjectEditor(),
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      );
}
