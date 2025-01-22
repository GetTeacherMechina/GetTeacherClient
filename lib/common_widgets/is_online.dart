import "package:flutter/material.dart";
import "package:getteacher/net/net.dart";
import "package:getteacher/net/web_socket_json_listener.dart";

class IsOnline extends StatelessWidget {
  const IsOnline({super.key, required this.connection});
  final WebSocketJson connection;

  @override
  Widget build(final BuildContext context) => StreamBuilder<bool>(
        stream: connection.isConnectedController.stream,
        builder: (
          final BuildContext context,
          final AsyncSnapshot<bool> isConnected,
        ) =>
            isConnected.mapSnapshot(
          onSuccess: (final bool isConnected) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              spacing: 10,
              children: <Widget>[
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isConnected ? Colors.green : Colors.red,
                  ),
                ),
                Text(isConnected ? "Online" : "Disconnected"),
                if (!isConnected)
                  IconButton(
                    onPressed: () async {
                      try {
                        await connection.reconnect();
                      } catch (e) {
                        // TODO: Validate
                      }
                    },
                    icon: const Icon(Icons.replay_outlined),
                  ),
              ],
            ),
          ),
        ),
      );
}
