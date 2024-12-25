import "package:flutter/material.dart";
import "package:getteacher/views/profile_screen/profile_screen_model.dart";

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Profile _profile = Profile(
    name: "Rick Astley",
    email: "john.doe@example.com",
    profileImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpSYk_W83N2xJNEfhep2ia56pzsUI1ucsPZg&s", // Placeholder image
  );

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                // Profile Picture
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(_profile.profileImage),
                ),
                const SizedBox(height: 20),
                // Profile Name
                Text(
                  _profile.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                // Profile Email
                Text(
                  _profile.email,
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
                      const SnackBar(content: Text("Edit Profile clicked")),
                    );
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit Profile"),
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
                const SizedBox(height: 100,),
              ],
            ),
          ),
        ),
      );
}
