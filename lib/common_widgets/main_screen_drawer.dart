import "package:flutter/material.dart";
import "package:getteacher/net/profile/profile_net_model.dart";
import "package:getteacher/views/meeting_history/meeting_history_screen.dart";
import "package:getteacher/views/register_screen/register_screen.dart";
import "package:getteacher/views/teacher_main_screen/teacher_settings_screen/teacher_settings_screen.dart";
import "package:getteacher/utils/local_jwt.dart";

class MainScreenDrawer extends StatelessWidget {
  const MainScreenDrawer({super.key, required this.profile});
  final ProfileResponseModel profile;
  @override
  Widget build(final BuildContext context) => Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(),
              child: Column(
                children: <Widget>[
                  const Text("Profile:"),
                  if (profile.isTeacher) const Text("Teacher"),
                  if (profile.isStudent) const Text("Student"),
                  Text("Name: ${profile.fullName}"),
                  Text("Email: ${profile.email}"),
                ],
              ),
            ),
            if (profile.isTeacher)
              ListTile(
                leading: const Icon(Icons.list),
                title: const Text("Teacher Settings"),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (final BuildContext context) =>
                          const TeacherSettingsScreen(),
                    ),
                  );
                },
              ),
            Expanded(
              child: Container(),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
                onTap: () {
                  LocalJwt.clearJwt();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (final BuildContext context) => RegisterScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
}
