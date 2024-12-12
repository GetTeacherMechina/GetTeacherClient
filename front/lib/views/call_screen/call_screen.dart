import 'package:flutter/material.dart';
import 'package:front/signalling.service.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

const String webSocketUrl = "ws://localhost:5000";

class _CallScreenState extends State<CallScreen> {
  int? id;
  final calleController = TextEditingController();
  @override
  void initState() {
    super.initState();
    SignallingService.instance.init(websocketUrl: webSocketUrl);
    setState(() {
      id = SignallingService.instance.id;
    });
  }

  _call() async {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: SelectableText("$id")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  controller: calleController,
                ),
              ),
              ElevatedButton(onPressed: _call, child: const Text("Call"))
            ],
          ),
        ),
      ),
    );
  }
}
