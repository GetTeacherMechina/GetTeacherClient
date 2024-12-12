import 'dart:developer';
import 'dart:math' hide log;
import 'package:socket_io_client/socket_io_client.dart';


class SignallingService {
  // instance of Socket
  Socket? socket;
  int id = 0;
  SignallingService._();
  static final instance = SignallingService._();

  init({required String websocketUrl}) {
    // init Socket
    id = Random.secure().nextInt(10000000);

    socket = io(websocketUrl, {
      "transports": ['websocket'],
      "query": {"callerId": id }
    });

    // listen onConnect event
    socket!.onConnect((data) {
      log("Socket connected !!");
    });

    // listen onConnectError event
    socket!.onConnectError((data) {
      log("Connect Error $data");
    });

    // connect socket
    socket!.connect();
  }
}
