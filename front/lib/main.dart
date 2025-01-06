import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:io' show Platform;       // Allows Platform checks
import 'package:flutter/foundation.dart' show kIsWeb; // Detects web

void main() {
  runApp(const MyApp());
}
String getSignalingServerUrl() {
  // for emulator
  if (kIsWeb) {
    return 'http://localhost:4433';
  } else if (Platform.isAndroid) {
    return 'http://10.0.2.2:4433';
  } else {
    return 'http://localhost:4433';
  }
}
String generateCallId([int length = 6]) {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final rnd = Random.secure();
  return List.generate(length, (_) => chars[rnd.nextInt(chars.length)]).join();
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter WebRTC Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String _signalingServerUrl = getSignalingServerUrl();

  late IO.Socket _socket;

  String _currentCallId = '';

  final TextEditingController _callIdController = TextEditingController();

  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;

  final _localRenderer = RTCVideoRenderer();
  final _remoteRenderer = RTCVideoRenderer();

  bool _isCalling = false;

  bool _isVideoEnabled = true;
  bool _isAudioEnabled = true;

  final Map<String, dynamic> _iceServers = {
    'iceServers': [
      {'urls': 'stun:stun.l.google.com:19302'},
      {
      'urls': 'turn:192.158.29.39:3478?transport=udp',
      'credential': 'JZEOEt2V3Qb0y27GRntt2u2PAYA=',
      'username': '28224511:1379330808'
    },
    {
      'urls': 'turn:192.158.29.39:3478?transport=tcp',
      'credential': 'JZEOEt2V3Qb0y27GRntt2u2PAYA=',
      'username': '28224511:1379330808'
    }
    ],
  };

  @override
  void initState() {
    super.initState();
    _initRenderers();
    _connectToSignalingServer();
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
      debugPrint('PeerConnection created');
    }
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  void _connectToSignalingServer() {
    _socket = IO.io(
      _signalingServerUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setExtraHeaders({'Content-Type': 'application/json'})
          .build(),
    );

    _socket.connect();

    _socket.onConnect((_) {
      debugPrint('Connected to signaling server');
    });

    _socket.on('offer', (data) async {
      debugPrint('Received offer: $data');
      final description = RTCSessionDescription(
        data['sdp'],
        data['type'],
      );

      if (_peerConnection == null) {
        await _createPeerConnection();
      }

      try {
        await _peerConnection?.setRemoteDescription(description);
        debugPrint('setRemoteDescription(offer) succeeded.');
      } catch (e) {
        debugPrint('Error setting remote description (offer): $e');
      }

      final answer = await _peerConnection?.createAnswer();
      if (answer != null) {
        await _peerConnection?.setLocalDescription(answer);
        _socket.emit('answer', {
          'callId': _currentCallId,
          'sdp': answer.sdp,
          'type': answer.type,
        });
        debugPrint('Sent answer to server.');
      }
    });

    _socket.on('answer', (data) async {
      debugPrint('Received answer: $data');
      if (_peerConnection == null) return;
      final description = RTCSessionDescription(
        data['sdp'],
        data['type'],
      );
      try {
        await _peerConnection!.setRemoteDescription(description);
        debugPrint('Caller set remote description (answer) successfully.');
      } catch (e) {
        debugPrint('Error setting remote description (answer): $e');
      }
    });

    _socket.on('candidate', (data) async {
      debugPrint('Received candidate: $data');
      if (_peerConnection == null) return;

      final candidate = RTCIceCandidate(
        data['candidate']['candidate'],
        data['candidate']['sdpMid'],
        data['candidate']['sdpMLineIndex'],
      );
      await _peerConnection?.addCandidate(candidate);
      debugPrint('addCandidate succeeded.');
    });

    _socket.onDisconnect((_) {
      debugPrint('Disconnected from signaling server');
    });
  }

  void _joinCallById(String callId) {
    _currentCallId = callId;
    _socket.emit('join-call', callId);
    debugPrint('emitted join call');
  }

  Future<void> _createPeerConnection() async {
    _peerConnection = await createPeerConnection(_iceServers);

    _peerConnection?.onIceConnectionState = (RTCIceConnectionState state) {
      debugPrint('ICE state changed: $state');
    };

    _peerConnection?.onConnectionState = (RTCPeerConnectionState state) {
      debugPrint('Connection state changed: $state');
    };

    if (_localStream == null) {
      _localStream = await navigator.mediaDevices
          .getUserMedia({'video': true, 'audio': true});
      _localRenderer.srcObject = _localStream;

      for (var track in _localStream!.getTracks()) {
        _peerConnection?.addTrack(track, _localStream!);
      }
    }

    _peerConnection?.onTrack = (RTCTrackEvent event) {
      debugPrint('Got remote track: ${event.track.id}');
      if (event.streams.isNotEmpty) {
        setState(() {
          _remoteRenderer.srcObject = event.streams.first;
        });
      }
    };

    _peerConnection?.onIceCandidate = (RTCIceCandidate candidate) {
      debugPrint('Sending candidate: ${candidate.toMap()}');
      _socket.emit('candidate', {
        'callId': _currentCallId,
        'candidate': candidate.toMap(),
      });
    };

    _peerConnection?.onConnectionState = (state) {
      debugPrint('Connection state changed: $state');
    };
  }

  Future<void> _startCall([String id = "-1"]) async {
    debugPrint('StartCall button pressed');
    final newCallId = (id=="-1") ? generateCallId() : id;
    debugPrint('Generated call ID: $newCallId');
    _joinCallById(newCallId);
    debugPrint('Joined call ID: $_currentCallId');
    if (_peerConnection == null) {
      await _createPeerConnection();
      debugPrint('PeerConnection created');
    }
    try {
      final offer = await _peerConnection!.createOffer();
      debugPrint('Created offer: $offer');

      await _peerConnection!.setLocalDescription(offer);
      debugPrint('Local description set: $offer');

      _socket.emit('offer', {
        'callId': _currentCallId,
        'sdp': offer.sdp,
        'type': offer.type,
      });
      debugPrint('Emitted offer to server');
  } catch (e, s) {
    debugPrint('Error in createOffer or setLocalDescription: $e\n$s');
  }
    setState(() {
      _isCalling = true;
    });
  }

  Future<void> _joinCall() async {
  final callId = _callIdController.text.trim();
  if (callId.isEmpty) {
    debugPrint('No call ID entered');
    return;
  }

  _joinCallById(callId);

  if (_peerConnection == null) {
    await _createPeerConnection();
    debugPrint('PeerConnection created in _joinCall().');
  }

  setState(() {
    _isCalling = true;
    _currentCallId = callId;
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
      _currentCallId = '';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentCallId.isNotEmpty
              ? 'Call ID: $_currentCallId'
              : 'Flutter WebRTC Demo',
        ),
      ),
      body: Column(
        children: [
          if (!_isCalling) Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _callIdController,
              decoration: const InputDecoration(
                labelText: 'Enter Call ID',
                hintText: 'E.g. ABC123',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _isCalling ? null : _startCall,
                child: const Text('Start New Call'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _isCalling ? null : _joinCall,
                child: const Text('Join Existing Call'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _isCalling ? _hangUp : null,
                child: const Text('Hang Up'),
              ),
            ],
          ),
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
}