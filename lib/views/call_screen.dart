import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_webrtc/flutter_webrtc.dart";
import "package:getteacher/net/ip_constants.dart";
import "package:getteacher/views/meeting_summary_screen/meeting_summary_screen.dart";
import "package:socket_io_client/socket_io_client.dart" as io;
import "dart:io" show Platform; // Allows Platform checks
import "package:flutter/foundation.dart" show kIsWeb; // Detects web
import "package:getteacher/theme/theme.dart";
import "package:getteacher/theme/widgets.dart";

final String url = kIsWeb
    ? "http://$debugHost:4433"
    : Platform.isAndroid
        ? "http://10.0.2.2:4433"
        : "http://localhost:4433";


class CallScreen extends StatefulWidget {
  const CallScreen({
    super.key,
    required this.guid,
    required this.shouldStartCall,
    required this.isStudent,
  });
  final String guid;
  final bool shouldStartCall;
  final bool isStudent;
  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {

  Timer? _timer;
  int _seconds = 0;

  late io.Socket _socket;

  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;

  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

  bool _isCalling = false;

  bool _isVideoEnabled = true;
  bool _isAudioEnabled = true;

  final Map<String, dynamic> _iceServers = <String, dynamic>{
    "iceServers": <Map<String, dynamic>>[
      <String, dynamic>{"urls": "stun:stun.l.google.com:19302"},
      <String, dynamic>{
        "urls": "turn:192.158.29.39:3478?transport=udp",
        "credential": "JZEOEt2V3Qb0y27GRntt2u2PAYA=",
        "username": "28224511:1379330808",
      },
      <String, dynamic>{
        "urls": "turn:192.158.29.39:3478?transport=tcp",
        "credential": "JZEOEt2V3Qb0y27GRntt2u2PAYA=",
        "username": "28224511:1379330808",
      }
    ],
  };

  @override
  void initState() {
    super.initState();
    _initRenderers();
    _connectToSignalingServer();
    widget.shouldStartCall ? _startCall() : _joinCall();
    _startTimer();
  }

  @override
  void dispose() async {
    _socket.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (final Timer timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  String _formatTime(final int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
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
    _socket = io.io(
      url,
      io.OptionBuilder()
          .setTransports(<String>["websocket"])
          .disableAutoConnect()
          .setExtraHeaders(
            <String, dynamic>{"Content-Type": "application/json"},
          )
          .build(),
    );

    _socket.connect();

    _socket.onConnect((final _) {
      debugPrint("Connected to signaling server");
    });

    _socket.on("offer", (final dynamic data) async {
      debugPrint("Received offer: $data");
      final RTCSessionDescription description = RTCSessionDescription(
        data["sdp"] as String?,
        data["type"] as String?,
      );

      if (_peerConnection == null) {
        await _createPeerConnection();
      }

      try {
        await _peerConnection?.setRemoteDescription(description);
        debugPrint("setRemoteDescription(offer) succeeded.");
      } catch (e) {
        debugPrint("Error setting remote description (offer): $e");
      }

      final RTCSessionDescription? answer =
          await _peerConnection?.createAnswer();
      if (answer != null) {
        await _peerConnection?.setLocalDescription(answer);
        _socket.emit("answer", <String, String?>{
          "callId": widget.guid,
          "sdp": answer.sdp,
          "type": answer.type,
        });
        debugPrint("Sent answer to server.");
      }
    });

    _socket.on("answer", (final dynamic data) async {
      debugPrint("Received answer: $data");
      if (_peerConnection == null) return;
      final RTCSessionDescription description = RTCSessionDescription(
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

    _socket.on("candidate", (final dynamic data) async {
      debugPrint("Received candidate: $data");
      if (_peerConnection == null) return;

      final RTCIceCandidate candidate = RTCIceCandidate(
        data["candidate"]["candidate"] as String?,
        data["candidate"]["sdpMid"] as String?,
        data["candidate"]["sdpMLineIndex"] as int?,
      );
      await _peerConnection?.addCandidate(candidate);
      debugPrint("addCandidate succeeded.");
    });

    _socket.onDisconnect((final _) {
      debugPrint("Disconnected from signaling server");
    });
  }

  void _joinCallById(final String callId) {
    _socket.emit("join-call", callId);

    /// !!!!!
    debugPrint("emitted join call");
  }

  Future<void> _createPeerConnection() async {
    _peerConnection = await createPeerConnection(_iceServers);

    _peerConnection?.onIceConnectionState =
        (final RTCIceConnectionState state) {
      debugPrint("ICE state changed: $state");
    };

    _peerConnection?.onConnectionState = (final RTCPeerConnectionState state) {
      debugPrint("Connection state changed: $state");
    };

    if (_localStream == null) {
      _localStream = await navigator.mediaDevices
          .getUserMedia(<String, dynamic>{"video": true, "audio": true});
      _localRenderer.srcObject = _localStream;

      for (final MediaStreamTrack track in _localStream!.getTracks()) {
        await _peerConnection?.addTrack(track, _localStream!);
      }
    }

    _peerConnection?.onTrack = (final RTCTrackEvent event) {
      debugPrint("Got remote track: ${event.track.id}");
      if (event.streams.isNotEmpty) {
        setState(() {
          _remoteRenderer.srcObject = event.streams.first;
        });
      }
    };

    _peerConnection?.onIceCandidate = (final RTCIceCandidate candidate) {
      debugPrint("Sending candidate: ${candidate.toMap()}");
      _socket.emit("candidate", <String, dynamic>{
        "callId": widget.guid,
        "candidate": candidate.toMap(),
      });
    };

    _peerConnection?.onConnectionState = (final RTCPeerConnectionState state) {
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
      final RTCSessionDescription offer = await _peerConnection!.createOffer();
      debugPrint("Created offer: $offer");

      await _peerConnection!.setLocalDescription(offer);
      debugPrint("Local description set: $offer");

      _socket.emit("offer", <String, String?>{
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
    // Close the peer connection
    await _peerConnection?.close();
    _peerConnection = null;

    // Stop and dispose local tracks
    if (_localStream != null) {
      for (final MediaStreamTrack track in _localStream!.getTracks()) {
        await track.stop();
      }
      await _localStream!.dispose();
      _localStream = null;
    }

    // Clear the renderers
    _localRenderer.srcObject = null;
    _remoteRenderer.srcObject = null;

    // Dispose of the renderers
    await _localRenderer.dispose();
    await _remoteRenderer.dispose();

    setState(() {
      _isCalling = false;
    });
  }

  void _toggleVideo() {
    final MediaStreamTrack? videoTrack = _localStream?.getVideoTracks().first;
    if (videoTrack != null) {
      videoTrack.enabled = !videoTrack.enabled;
      setState(() {
        _isVideoEnabled = videoTrack.enabled;
      });
    }
  }

  void _toggleAudio() {
    final MediaStreamTrack? audioTrack = _localStream?.getAudioTracks().first;
    if (audioTrack != null) {
      audioTrack.enabled = !audioTrack.enabled;
      setState(() {
        _isAudioEnabled = audioTrack.enabled;
      });
    }
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          _formatTime(_seconds),
          style: AppTheme.appBarTextStyle,
        ),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: AppTheme.whiteColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: <BoxShadow>[AppTheme.defaultShadow],
                  color: AppTheme.whiteColor,
                ),
                child: Row(
                  children: <Widget>[
                    if (_isCalling)
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          child: RTCVideoView(_localRenderer, mirror: true),
                        ),
                      ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: _isCalling
                            ? const BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              )
                            : BorderRadius.circular(15),
                        child: RTCVideoView(_remoteRenderer),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: AppTheme.whiteColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: <BoxShadow>[AppTheme.defaultShadow],
              ),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    hoverColor: Colors.grey,
                    icon: Icon(
                      _isVideoEnabled ? Icons.videocam : Icons.videocam_off,
                      color: AppTheme.primaryColor,
                      size: 30,
                    ),
                    onPressed: _toggleVideo,
                  ),
                  IconButton(
                    hoverColor: Colors.grey,
                    icon: Icon(
                      _isAudioEnabled ? Icons.mic : Icons.mic_off,
                      color: AppTheme.primaryColor,
                      size: 30,
                    ),
                    onPressed: _toggleAudio,
                  ),
                  IconButton(
                    hoverColor: Colors.grey,
                    onPressed: () async {
                      _timer?.cancel();
                      await _hangUp();
                      if (widget.isStudent) {
                        unawaited(
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute<void>(
                              builder: (final BuildContext context) =>
                                  StarRatingScreen(meetingGuid: widget.guid),
                            ),
                          ),
                        );
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                    icon: const Icon(Icons.call_end),
                    color: Colors.red,
                    iconSize: 36,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
}
