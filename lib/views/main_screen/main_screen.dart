import "package:flutter/material.dart";
import "package:getteacher/net/net.dart";
import "package:getteacher/net/profile/profile.dart";
import "package:getteacher/net/profile/profile_net_model.dart";

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(final BuildContext context) => Scaffold(
        body: FutureBuilder<ProfileResponseModel>(
          future: profile(),
          builder: (
            final BuildContext context,
            final AsyncSnapshot<ProfileResponseModel> snapshot,
          ) =>
              snapshot.mapSnapshot(
            onSuccess: (final ProfileResponseModel profile) => Center(
              child: Text(
                "Message from server: ${profile.email}, ${profile.fullName}",
              ),
            ),
          ),
        ),
      );
}
