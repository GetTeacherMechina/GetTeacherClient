import "package:flutter/material.dart";
import "dart:math";
import "package:flutter_webrtc/flutter_webrtc.dart";
import "package:socket_io_client/socket_io_client.dart" as IO;
import "dart:io" show Platform;       // Allows Platform checks
import "package:flutter/foundation.dart" show kIsWeb; // Detects web

String getSignalingServerUrl() {
  // for emulator
  if (kIsWeb) {
    return "http://localhost:4433";
  } else if (Platform.isAndroid) {
    return "http://10.0.2.2:4433";
  } else {
    return "http://localhost:4433";
  }
}
String generateCallId([int length = 6]) {
  const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
  final rnd = Random.secure();
  return List.generate(length, (_) => chars[rnd.nextInt(chars.length)]).join();
}

class CallScreen extends StatefulWidget {
  const CallScreen({super.key,required this.guid,required this.shouldStartCall});
  final String guid;
  final bool shouldStartCall;
  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final String _signalingServerUrl = getSignalingServerUrl();

  late IO.Socket _socket;



  late final TextEditingController _callIdController = TextEditingController(text: widget.guid);

  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;

  final _localRenderer = RTCVideoRenderer();
  final _remoteRenderer = RTCVideoRenderer();

  bool _isCalling = false;

  bool _isVideoEnabled = true;
  bool _isAudioEnabled = true;

  final Map<String, dynamic> _iceServers = {
    "iceServers": [
      {"urls": "stun:stun.l.google.com:19302"},
      {
      "urls": "turn:192.158.29.39:3478?transport=udp",
      "credential": "JZEOEt2V3Qb0y27GRntt2u2PAYA=",
      "username": "28224511:1379330808"
    },
    {
      "urls": "turn:192.158.29.39:3478?transport=tcp",
      "credential": "JZEOEt2V3Qb0y27GRntt2u2PAYA=",
      "username": "28224511:1379330808"
    }
    ],
  };

  @override
  void initState() {
    super.initState();
    _initRenderers();
    _connectToSignalingServer();
    widget.shouldStartCall ? _startCall() : _joinCall();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    _socket.dispose();
    super.dispose();
  }

  Future<void> _initRenderers() async {
    if (_peerConnection == null) {
      await _createPeerConnection();
      debugPrint("PeerConnection created");
    }
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  void _connectToSignalingServer() {
    _socket = IO.io(
      _signalingServerUrl,
      IO.OptionBuilder()
          .setTransports(["websocket"])
          .disableAutoConnect()
          .setExtraHeaders({"Content-Type": "application/json"})
          .build(),
    );

    _socket.connect();

    _socket.onConnect((_) {
      debugPrint("Connected to signaling server");
    });

    _socket.on("offer", (data) async {
      debugPrint("Received offer: $data");
      final description = RTCSessionDescription(
        data["sdp"] as String?,
        data["type"] as String?,
      );

    // _socket.on("teacher-call", (data) {
    //   final Map<String, String?> data_map = data as Map<String, String>;
    //   debugPrint('Received "start-call" event from server with data: $data');
    //   final callId = data_map["callId"] ?? generateCallId(); // In case we decide to generate the id in the server (essential)
    //   _startCall(callId);
    //   });

    // _socket.on("student-call", (data) {
    //   debugPrint('Received "start-call" event from server with data: $data');
    //   final String callId = data["callId"] as String ?? generateCallId(); // WE MUST GET THIS FROM THE SERVER!!
    //   _joinCall(callId);
    //   });

      if (_peerConnection == null) {
        await _createPeerConnection();
      }

      try {
        await _peerConnection?.setRemoteDescription(description);
        debugPrint("setRemoteDescription(offer) succeeded.");
      } catch (e) {
        debugPrint("Error setting remote description (offer): $e");
      }

      final answer = await _peerConnection?.createAnswer();
      if (answer != null) {
        await _peerConnection?.setLocalDescription(answer);
        _socket.emit("answer", {
          "callId": widget.guid,
          "sdp": answer.sdp,
          "type": answer.type,
        });
        debugPrint("Sent answer to server.");
      }
    });

    _socket.on("answer", (data) async {
      debugPrint("Received answer: $data");
      if (_peerConnection == null) return;
      final description = RTCSessionDescription(
        data["sdp"] as String?,
        data["type"] as String?,
      );
      try {
        await _peerConnection!.setRemoteDescription(description);
        debugPrint("Caller set remote description (answer) successfully.");
      } catch (e) {
        debugPrint("Error setting remote description (answer): $e");
      }
    });

    _socket.on("candidate", (data) async {
      debugPrint("Received candidate: $data");
      if (_peerConnection == null) return;

      final candidate = RTCIceCandidate(
        data["candidate"]["candidate"] as String?,
        data["candidate"]["sdpMid"] as String?,
        data["candidate"]["sdpMLineIndex"] as int?,
      );
      await _peerConnection?.addCandidate(candidate);
      debugPrint("addCandidate succeeded.");
    });

    _socket.onDisconnect((_) {
      debugPrint("Disconnected from signaling server");
    });
  }

  void _joinCallById(String callId) {
    _socket.emit("join-call", callId); /// !!!!!
    debugPrint("emitted join call");
  }

  Future<void> _createPeerConnection() async {
    _peerConnection = await createPeerConnection(_iceServers);

    _peerConnection?.onIceConnectionState = (RTCIceConnectionState state) {
      debugPrint("ICE state changed: $state");
    };

    _peerConnection?.onConnectionState = (RTCPeerConnectionState state) {
      debugPrint("Connection state changed: $state");
    };

    if (_localStream == null) {
      _localStream = await navigator.mediaDevices
          .getUserMedia({"video": true, "audio": true});
      _localRenderer.srcObject = _localStream;

      for (var track in _localStream!.getTracks()) {
        _peerConnection?.addTrack(track, _localStream!);
      }
    }

    _peerConnection?.onTrack = (RTCTrackEvent event) {
      debugPrint("Got remote track: ${event.track.id}");
      if (event.streams.isNotEmpty) {
        setState(() {
          _remoteRenderer.srcObject = event.streams.first;
        });
      }
    };

    _peerConnection?.onIceCandidate = (RTCIceCandidate candidate) {
      debugPrint("Sending candidate: ${candidate.toMap()}");
      _socket.emit("candidate", {
        "callId": widget.guid,
        "candidate": candidate.toMap(),
      });
    };

    _peerConnection?.onConnectionState = (state) {
      debugPrint("Connection state changed: $state");
    };
  }

  Future<void> _startCall() async {
    debugPrint("StartCall button pressed");
    debugPrint("Generated call ID: ${widget.guid}");
    _joinCallById(widget.guid);
    debugPrint("Joined call ID: ${widget.guid}");
    if (_peerConnection == null) {
      await _createPeerConnection();
      debugPrint("PeerConnection created");
    }
    try {
      final offer = await _peerConnection!.createOffer();
      debugPrint("Created offer: $offer");

      await _peerConnection!.setLocalDescription(offer);
      debugPrint("Local description set: $offer");

      _socket.emit("offer", {
        "callId": widget.guid,
        "sdp": offer.sdp,
        "type": offer.type,
      });
      debugPrint("Emitted offer to server");
  } catch (e, s) {
    debugPrint("Error in createOffer or setLocalDescription: $e\n$s");
  }
    setState(() {
      _isCalling = true;
    });
  }

  Future<void> _joinCall() async {

  _joinCallById(widget.guid);

  if (_peerConnection == null) {
    await _createPeerConnection();
    debugPrint("PeerConnection created in _joinCall().");
  }

  setState(() {
    _isCalling = true;
  });
}

  Future<void> _hangUp() async {
    await _peerConnection?.close();
    _peerConnection = null;

    _localStream?.dispose();
    _localStream = null;

    setState(() {
      _remoteRenderer.srcObject = null;
      _localRenderer.srcObject = null;
      _isCalling = false;
    });
  }

  void _toggleVideo() {
  final videoTrack = _localStream?.getVideoTracks().first;
  if (videoTrack != null) {
    videoTrack.enabled = !videoTrack.enabled;
    setState(() {
      _isVideoEnabled = videoTrack.enabled;
    });
  }
}

void _toggleAudio() {
  final audioTrack = _localStream?.getAudioTracks().first;
  if (audioTrack != null) {
    audioTrack.enabled = !audioTrack.enabled;
    setState(() {
      _isAudioEnabled = audioTrack.enabled;
    });
  }
}

  @override
  Widget build(final BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(
              "Call ID: ${widget.guid}"
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                if (_isCalling)
                  Expanded(
                    child: RTCVideoView(_localRenderer, mirror: true),
                  ),
                Expanded(
                  child: RTCVideoView(_remoteRenderer),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  _isVideoEnabled ? Icons.videocam : Icons.videocam_off,
                ),
                onPressed: _toggleVideo,
              ),
              IconButton(
                icon: Icon(
                  _isAudioEnabled ? Icons.mic : Icons.mic_off,
                ),
                onPressed: _toggleAudio,
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
}
