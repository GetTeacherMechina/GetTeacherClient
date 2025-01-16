import "package:flutter/material.dart";

class StudentSettingsScreen extends StatefulWidget {
  const StudentSettingsScreen({super.key});

  @override
  State<StudentSettingsScreen> createState() => _StudentSettingsScreenState();
}

class _StudentSettingsScreenState extends State<StudentSettingsScreen> {
  double sliderValue = 0;

  void _onSlider(final double value) {
    setState(() {
      sliderValue = value;
    });
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Student Settings"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("cheaper teachers"),
                  Text("balanced"),
                  Text("better teachers"),
                ],
              ),
              Slider(value: sliderValue, onChanged: _onSlider),
            ],
          ),
        ),
      );
}
