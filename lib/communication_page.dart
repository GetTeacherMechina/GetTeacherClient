import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class CommunicationPage extends StatefulWidget {
  const CommunicationPage({super.key});

  @override
  State<CommunicationPage> createState() => _CommunicationPageState();
}

class _CommunicationPageState extends State<CommunicationPage> {
  late RTCPeerConnection _conn;
  final _localRenderer = RTCVideoRenderer();
  final _remoteRenderer = RTCVideoRenderer();
  MediaStream? _localStream;

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    _conn.close();
    super.dispose();
  }

  Future<void> _initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  Future<void> _startWebRTC() async {
    // Get local stream
    _localStream = await navigator.mediaDevices.getUserMedia({
      'audio': true,
      'video': true,
    });
    _localRenderer.srcObject = _localStream;

    // Create peer connection
    _conn = await createPeerConnection({
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'}, // STUN server
      ],
    });

    // Add local stream to peer connection
    _localStream!.getTracks().forEach((track) {
      _conn.addTrack(track, _localStream!);
    });

    // Handle remote stream
    _conn.onTrack = (RTCTrackEvent event) {
      if (event.streams.isNotEmpty) {
        _remoteRenderer.srcObject = event.streams[0];
      }
    };

    // Create offer
    var offer = await _conn.createOffer();
    await _conn.setLocalDescription(offer);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            const Text("local video"),
            RTCVideoView(_localRenderer)
          ],
        ),
        Column(
          children: [
            const Text("remote video"),
            RTCVideoView(_remoteRenderer)
          ],
        ),
      ],
    );
  }
}
