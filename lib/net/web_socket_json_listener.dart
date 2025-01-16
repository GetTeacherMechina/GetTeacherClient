import "dart:convert";

import "package:flutter/foundation.dart";
import "package:getteacher/net/ip_constants.dart";
import "package:getteacher/net/net.dart";
import "package:web_socket_channel/web_socket_channel.dart";

class WebSocketJson {
  WebSocketJson._(this.webSocket, this.onNewDatas) {
    webSocket.stream.listen(
      (final dynamic message) {
        if (message is String) {
          try {
            final dynamic data = jsonDecode(message);
            if (data is Map<String, dynamic>) {
              for (final void Function(Map<String, dynamic>) onNewData in onNewDatas) {
                onNewData(data);
              }
            } else {}
          } catch (e) {
            //
          }
        } else if (message is List<int>) {
        } else {}
      },
      onError: (final Object error) {
        if (kDebugMode) {
          print("Websocket Error: $error");
        }
      },
      onDone: () {
        // TODO move to main screen
        if (kDebugMode) {
          print("Done");
        }
      },
    );
  }

  void close() {
    webSocket.sink.close();
  }

  List<void Function(Map<String, dynamic>)> onNewDatas;
  WebSocketChannel webSocket;

  void addNewListener(final void Function(Map<String,dynamic>) onNewData) {
    onNewDatas.add(onNewData);
  }
  void removeListener(final void Function(Map<String,dynamic>) onNewData) {
    onNewDatas.remove(onNewData);
  }

  static Future<WebSocketJson> connect(
    final void Function(Map<String, dynamic>) onNewData,
  ) async {
    final WebSocketChannel websocket = WebSocketChannel.connect(
      wsUri("/websocket"),
    );
    websocket.sink.add(getClient().jwt());

    return WebSocketJson._(
        websocket, <void Function(Map<String, dynamic>)>[onNewData]);
  }
}
