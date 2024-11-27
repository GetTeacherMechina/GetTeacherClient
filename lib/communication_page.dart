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
  final _offerController = TextEditingController();
  final _remoteController = TextEditingController();
  MediaStream? _localStream;
  String message = "";

  @override
  void initState() {
    super.initState();
    _initRenderers();
    _startWebRTC();
  }

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
    _offerController.text = "${offer.sdp ?? ""}|||||${offer.type ?? ""}";
  }

  Future<void> _loadRemote() async {
    final data = _remoteController.text.split("|||||");
    final sdp = data[0];
    final type = data[1];

    await _conn.setRemoteDescription(RTCSessionDescription(sdp, type));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              const Text("local video"),
              SizedBox(
                height: 200,
                width: 200,
                child: RTCVideoView(
                  _localRenderer,
                  mirror: true,
                  objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                ),
              ),
              const Text("remote video"),
              SizedBox(
                height: 200,
                width: 200,
                child: RTCVideoView(
                  _remoteRenderer,
                  objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 100,
          child: TextField(
            controller: _offerController,
            minLines: 10,
            maxLines: 1000,
          ),
        ),
        SizedBox(
          height: 100,
          child: TextField(
            controller: _remoteController,
            minLines: 10,
            maxLines: 1000,
          ),
        ),
        ElevatedButton(
            onPressed: () => _loadRemote(), child: const Text("Load()"))
      ],
    );
  }
}
