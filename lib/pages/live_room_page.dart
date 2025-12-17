import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../zego_config.dart';
import '../services/socket_service.dart';
import '../widgets/seat_panel.dart';

class LiveRoomPage extends StatefulWidget {
  final String roomId;
  final String userId;
  final String userName;
  final bool isHost;

  const LiveRoomPage({
    super.key,
    required this.roomId,
    required this.userId,
    required this.userName,
    required this.isHost,
  });

  @override
  State<LiveRoomPage> createState() => _LiveRoomPageState();
}

class _LiveRoomPageState extends State<LiveRoomPage> {
  final SocketService socketService = SocketService();

  bool micOn = false;

  // ✅ এখানেই initState
  @override
  void initState() {
    super.initState();

    // 🔌 socket connect
    socketService.connect(widget.userId, widget.roomId);

    // 🔇 host mute করলে
    socketService.socket.on("user-muted", (data) {
      if (data["userId"] == widget.userId) {
        setState(() => micOn = false);
      }
    });

    // 🔊 host unmute করলে
    socketService.socket.on("user-unmuted", (data) {
      if (data["userId"] == widget.userId) {
        setState(() => micOn = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Live Voice Room",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          /// 🎙️ LIVE VOICE (ZEGO)
          Expanded(
            child: ZegoUIKitPrebuiltCall(
              appID: ZegoConfig.appID,
              appSign: ZegoConfig.serverSecret,
              userID: widget.userId,
              userName: widget.userName,
              callID: widget.roomId,
              config: ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
                ..turnOnCameraWhenJoining = false
                ..turnOnMicrophoneWhenJoining = micOn
                ..maxUsers = 9,
            ),
          ),

          /// 🪑 SEAT PANEL
          SizedBox(
            height: 220,
            child: SeatPanel(
              roomId: widget.roomId,
              userId: widget.userId,
              isHost: widget.isHost,
              onMicChange: (on) {
                setState(() {
                  micOn = on;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}