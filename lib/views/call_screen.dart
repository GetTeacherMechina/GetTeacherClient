import "package:flutter/material.dart";
import "package:getteacher/net/call/call_model.dart";

class CallScreen extends StatelessWidget {
  const CallScreen({super.key, required this.message});

  final CallModel message;

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text("You are in a call with: ${message.companionName}"),
        ),
      );
}
