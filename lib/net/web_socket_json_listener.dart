import "dart:async";
import "dart:convert";

import "package:flutter/foundation.dart";
import "package:getteacher/net/ip_constants.dart";
import "package:getteacher/net/net.dart";
import "package:web_socket_channel/web_socket_channel.dart";

class WebSocketJson {
  WebSocketJson._(this.webSocket, this.onNewDatas)
      : isConnectedController = StreamController<bool>() {
    _startListening().onError((final _, final __) {
      isConnectedController.sink.add(false);
    }).then((final _) {
      isConnectedController.sink.add(true);
    });
  }

  Future<void> _startListening() async {
    isConnectedController.add(false);
    await webSocket.ready;
    webSocket.stream.listen(
      (final dynamic message) {
        if (message is String) {
          try {
            final dynamic data = jsonDecode(message);
            if (data is Map<String, dynamic>) {
              for (final void Function(Map<String, dynamic>) onNewData
                  in onNewDatas) {
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
        isConnectedController.add(false);
        if (kDebugMode) {
          print("Websocket Error: $error");
        }
      },
      onDone: () {
        // TODO move to main screen
        isConnectedController.add(false);
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
  final StreamController<bool> isConnectedController;

  void addNewListener(final void Function(Map<String, dynamic>) onNewData) {
    onNewDatas.add(onNewData);
  }

  void removeListener(final void Function(Map<String, dynamic>) onNewData) {
    onNewDatas.remove(onNewData);
  }

  Future<void> reconnect() async {
    try {
      await webSocket.sink.close();
    } catch (_) {}
    isConnectedController.add(false);
    webSocket = WebSocketChannel.connect(
      wsUri("/websocket"),
    );
    await _startListening();
    isConnectedController.add(true);
  }

  static WebSocketJson connect(
    final void Function(Map<String, dynamic>) onNewData,
  ) {
    final WebSocketChannel websocket = WebSocketChannel.connect(
      wsUri("/websocket"),
    );
    websocket.sink.add(getClient().jwt());

    return WebSocketJson._(
      websocket,
      <void Function(Map<String, dynamic>)>[onNewData],
    );
  }
}
