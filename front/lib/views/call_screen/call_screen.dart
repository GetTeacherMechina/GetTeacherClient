import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:front/signalling.service.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  int? id;
  int? callsTo;
  final calleController = TextEditingController();

  final _myVideoRenderer = RTCVideoRenderer();
  final _otherVideoRenderer = RTCVideoRenderer();

  late RTCPeerConnection _connection;

  final _socket = SignallingService.instance.socket;

  @override
  void initState() {
    super.initState();
    setState(() {
      id = SignallingService.instance.id;
    });

    _initWebRTC();
  }

  _initWebRTC() async {
    await _myVideoRenderer.initialize();
    await _otherVideoRenderer.initialize();
    _connection = await createPeerConnection({
      'iceServers': [
        {
          'urls': [
            'stun:stun1.l.google.com:19302',
            'stun:stun2.l.google.com:19302'
          ]
        }
      ]
    });
    _connection.onIceCandidate = (ice) {
      print("got ice");
      if (callsTo != null) {
        print("used ice");
        _socket.emit(
            "IceCandidate", {"calleeId": callsTo, "iceCandidate": ice.toMap()});
      }
    };
    final stream = await navigator.mediaDevices
        .getUserMedia({"video": true, "audio": true});
    await _connection.addStream(stream);
    setState(() {
      _myVideoRenderer.srcObject = stream;
    });

    _socket.on(
      "newCall",
      (data) async {
        print("called");
        final offer = data['sdpOffer'];
        _connection.setRemoteDescription(
          RTCSessionDescription(offer['sdp'], offer['type']),
        );
        callsTo = int.parse(data['callerId']);
        final ans = await _connection.createAnswer();
        print("sent answer");
        _socket.emit("answerCall", {
          "callerId": data['callerId'],
          "sdpAnswer": ans.toMap(),
        });
      },
    );

    _socket.on(
      "callAnswered",
      (data) {
        print("got answered");
        _connection.setRemoteDescription(RTCSessionDescription(
            data['sdpAnswer']['sdp'], data['sdpAnswer']['type']));
      },
    );

    _socket.on(
      "iceCandidate",
      (data) {
        String candidate = data["iceCandidate"]["candidate"];
        String sdpMid = data["iceCandidate"]["id"];
        int sdpMLineIndex = data["iceCandidate"]["label"];

        // add iceCandidate
        _connection.addCandidate(RTCIceCandidate(
          candidate,
          sdpMid,
          sdpMLineIndex,
        ));
      },
    );
    _connection.onTrack = (data) {
      _otherVideoRenderer.srcObject = data.streams[0];
    };
  }

  _call() async {
    final offer = await _connection.createOffer();

    _connection.setLocalDescription(offer);
    print("calling");
    callsTo = int.parse(calleController.text);
    _socket.emit("makeCall",
        {"calleeId": calleController.text, "sdpOffer": offer.toMap()});
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
              const Text("other:"),
              SizedBox(
                width: 300,
                height: 300,
                child: RTCVideoView(_otherVideoRenderer),
              ),
              const Text("you:"),
              SizedBox(
                width: 300,
                height: 300,
                child: RTCVideoView(_myVideoRenderer),
              ),
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
