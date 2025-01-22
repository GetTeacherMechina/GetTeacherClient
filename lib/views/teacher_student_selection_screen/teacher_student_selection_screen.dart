import "package:flutter/material.dart";
import "package:getteacher/net/profile/profile_net_model.dart";
import "package:getteacher/theme/theme.dart";
import "package:getteacher/theme/widgets.dart";
import "package:getteacher/views/student_main_screen/student_main_screen.dart";
import "package:getteacher/views/teacher_main_screen/teacher_main_screen.dart";

class TeacherStudentSelection extends StatefulWidget {
  const TeacherStudentSelection({super.key, required this.profile});

  final ProfileResponseModel profile;

  @override
  State<TeacherStudentSelection> createState() =>
      _TeacherStudentSelectionState();
}

class _TeacherStudentSelectionState extends State<TeacherStudentSelection> {
  @override
  Widget build(final BuildContext context) => Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        body: 
        Stack(
          children: <Widget>[

          AppWidgets.fadedBigLogo(),
          AppWidgets.bubblesImage(),
        Center(
          child: Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: AppTheme.whiteColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [AppTheme.defaultShadow],
            ),
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  "Select Your Role",
                  style: AppTheme.headingStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute<void>(
                        builder: (final BuildContext context) =>
                            TeacherMainScreen(profile: widget.profile),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: AppTheme.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                  ),
                  child: const Text("Continue as Teacher"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute<void>(
                        builder: (final BuildContext context) =>
                            StudentMainScreen(profile: widget.profile),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accentColor,
                    foregroundColor: AppTheme.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                  ),
                  child: const Text("Continue as Student"),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
