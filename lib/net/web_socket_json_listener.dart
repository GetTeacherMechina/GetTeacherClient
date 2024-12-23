import "dart:convert";

import "package:getteacher/net/net.dart";
import "package:web_socket_channel/web_socket_channel.dart";

class WebSocketJson {
  WebSocketJson._(this.webSocket, this.onNewData) {
    webSocket.stream.listen(
      (final dynamic message) {
        if (message is String) {
          try {
            final dynamic data = jsonDecode(message);
            if (data is Map<String, dynamic>) {
              onNewData(data);
            } else {}
          } catch (e) {}
        } else if (message is List<int>) {
        } else {}
      },
      onError: (final Object error) {},
      onDone: () {},
    );
  }

  void Function(Map<String, dynamic>) onNewData;
  WebSocketChannel webSocket;

  static Future<WebSocketJson> connect(
    final void Function(Map<String, dynamic>) onNewData,
  ) async {
    final WebSocketChannel websocket = WebSocketChannel.connect(
      wsUri("/api/v1/websocket"),
    );

    return WebSocketJson._(websocket, onNewData);
  }
}
