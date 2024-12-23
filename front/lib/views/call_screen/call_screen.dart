import 'dart:js_interop';

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

  MediaStream? _myStream;
  MediaStream? _otherStream;

  late RTCPeerConnection _connection;

  final _socket = SignallingService.instance.socket;

  final List<RTCIceCandidate> _rtcIceCadidates = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      id = SignallingService.instance.id;
    });

    _initWebRTC();
  }

  _initWebRTC() async {
    _myVideoRenderer.initialize();
    _otherVideoRenderer.initialize();
    _connection = await createPeerConnection({
      'iceServers': [
        {
          'urls': [
            'stun:stun1.l.google.com:3478',
            'stun:stun1.l.google.com:19302',
            'stun:stun2.l.google.com:19302'
          ]
        }
      ]
    });
    _connection.onConnectionState = (data) {
      print("state: ${data.name}");
    };

    _connection.onIceConnectionState = (data) {
      print("ice state: ${data.name}");
    };

    _connection.onTrack = (data) {
      if (data.streams[0].getTracks().any((a) => a.kind == "video")) {
        print("got the track!!!! ${data.streams.length}");
        print(data.streams[0]);
        setState(() {
          _otherStream = data.streams[0];
          _otherVideoRenderer.srcObject = _otherStream;
        });
      }
    };

    _connection.onIceCandidate = (ice) {
      _rtcIceCadidates.add(ice);
    };
    // await _connection.restartIce();
    final stream = await navigator.mediaDevices
        .getUserMedia({"video": true, 'audio': true});
    _myStream = stream;
    final tracks = stream.getTracks();
    for (var track in tracks) {
      await _connection.addTrack(track, stream);
    }
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
        print("other: $callsTo");
        final ans = await _connection.createAnswer();
        print("sent answer");
        // print("the type is fucking: ${data['callerId'].runtimeType}");
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

        for (RTCIceCandidate candidate in _rtcIceCadidates) {
          print("ice candidate: ${candidate.toMap()}");
          _socket.emit("iceCandidate", {
            "calleeId": callsTo.toString(),
            "iceCandidate": candidate.toMap()
          });

          _connection.addCandidate(candidate);
        }
        print("used ice");
        _rtcIceCadidates.clear();
      },
    );
    _socket.onAny((a, data) {
      if (a.contains("ceC")) {
        print(data['iceCandidate']);
        String candidate = data["iceCandidate"]["candidate"];
        String sdpMid = data["iceCandidate"]["sdpMid"];
        int sdpMLineIndex = data["iceCandidate"]["sdpMLineIndex"];
        print('got ice from other');
        // add iceCandidate
        _connection.addCandidate(RTCIceCandidate(
          candidate,
          sdpMid,
          sdpMLineIndex,
        ));
      }
    });
    _socket.on(
      "iceCandidate",
      (data) {
        String candidate = data["iceCandidate"]["candidate"];
        String sdpMid = data["iceCandidate"]["sdpMid"];
        int sdpMLineIndex = data["iceCandidate"]["sdpMLineIndex"];
        // add iceCandidate
        print('got ice from other');
        _connection.addCandidate(RTCIceCandidate(
          candidate,
          sdpMid,
          sdpMLineIndex,
        ));
      },
    );
  }

  _call() async {
    final offer = await _connection.createOffer();

    _connection.setLocalDescription(offer);
    print("calling");
    callsTo = int.parse(calleController.text);
    print("other: $callsTo");
    _socket.emit("makeCall",
        {"calleeId": calleController.text, "sdpOffer": offer.toMap()});
  }

  @override
  Widget build(BuildContext context) {
    print("rebuild alllllll");
    print(_otherVideoRenderer.srcObject?.getTracks().map((a) {
      print(a.jsify());
    }));
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
