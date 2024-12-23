import "package:flutter/material.dart";

class TeacherMainScreen extends StatelessWidget {
  const TeacherMainScreen({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Center(
          child: RawMaterialButton(
            onPressed: () {},
            elevation: 2.0,
            fillColor: Colors.blue,
            constraints: const BoxConstraints(minWidth: 0.0),
            child: const Icon(
              Icons.pause,
              size: 35.0,
            ),
            padding: const EdgeInsets.all(15.0),
            shape: const CircleBorder(),
          ),
        ),
      );
}
