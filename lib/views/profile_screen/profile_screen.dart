import "package:flutter/material.dart";
import "package:getteacher/net/net.dart";
import "package:getteacher/net/profile/profile.dart";
import "package:getteacher/net/profile/profile_net_model.dart";

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Future<ProfileResponseModel> future = profile();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: FutureBuilder<ProfileResponseModel>(
          future: future,
          builder: (final BuildContext context,
                  final AsyncSnapshot<ProfileResponseModel> snapshot) =>
              snapshot.mapSnapshot(
                  onSuccess: (final ProfileResponseModel profile) => Center(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const SizedBox(height: 20),
                              // Profile Picture
                              const CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpSYk_W83N2xJNEfhep2ia56pzsUI1ucsPZg&s",
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Profile Name
                              Text(
                                profile.fullName,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Profile Email
                              Text(
                                profile.email,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 30),
                              // Edit Profile Button
                              ElevatedButton.icon(
                                onPressed: () {
                                  // Add logic for editing profile
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Edit Profile clicked")),
                                  );
                                },
                                icon: const Icon(Icons.edit),
                                label: const Text("Edit Profile"),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                      )),
        ),
      );
}
