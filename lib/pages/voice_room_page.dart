import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';
import '../zego_config.dart';
import '../widgets/gift_panel.dart';
import '../widgets/game_panel.dart';
import '../widgets/gift_animation.dart';
import '../models/gift_model.dart';
import '../services/api_service.dart';
import 'seat_control.dart';

class VoiceRoomPage extends StatefulWidget {
  final String roomId;
  final bool isHost;

  const VoiceRoomPage({
    super.key,
    required this.roomId,
    required this.isHost,
  });

  @override
  State<VoiceRoomPage> createState() => _VoiceRoomPageState();
}

class _VoiceRoomPageState extends State<VoiceRoomPage> {
  int totalCoins = 0;
  late String userId;
  late String userName;

  @override
  void initState() {
    super.initState();
    userId = DateTime.now().millisecondsSinceEpoch.toString();
    userName = "User_$userId";
  }

  void _sendGift(GiftModel gift) async {
    setState(() {
      totalCoins += gift.price;
    });

    // 🎁 show animation
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => GiftAnimation(gift: gift),
    );

    // 🌐 send to backend
    await ApiService.sendGift(
      roomId: widget.roomId,
      userId: userId,
      gift: gift,
    );
  }

  void _openGiftPanel() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return GiftPanel(
          onSendGift: (gift) => _sendGift(gift),
        );
      },
    );
  }

  void _openGamePanel() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const GamePanel(),
    );
  }

  void _openSeatControl() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SeatControlPage(isHost: widget.isHost),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.isHost
        ? ZegoUIKitPrebuiltLiveAudioRoomConfig.host()
        : ZegoUIKitPrebuiltLiveAudioRoomConfig.audience();

    config.seatConfig = ZegoLiveAudioRoomSeatConfig(
      numberOfSeats: ZegoConfig.seatCount,
      rowConfigs: const [
        ZegoLiveAudioRoomSeatRowConfig(count: 2),
        ZegoLiveAudioRoomSeatRowConfig(count: 2),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isHost ? "Host Room" : "Voice Room"),
        actions: [
          if (widget.isHost)
            IconButton(
              icon: const Icon(Icons.settings_voice),
              onPressed: _openSeatControl,
            ),
        ],
      ),
      body: Stack(
        children: [
          ZegoUIKitPrebuiltLiveAudioRoom(
            appID: ZegoConfig.appID,
            appSign: ZegoConfig.appSign,
            userID: userId,
            userName: userName,
            roomID: widget.roomId,
            config: config,
          ),

          // 💰 Coin counter
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "Coins: $totalCoins",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),

          // 🎁 Gift Button
          Positioned(
            bottom: 30,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.pink,
              heroTag: "gift",
              onPressed: _openGiftPanel,
              child: const Icon(Icons.card_giftcard),
            ),
          ),

          // 🎮 Game Button
          Positioned(
            bottom: 30,
            right: 90,
            child: FloatingActionButton(
              backgroundColor: Colors.blue,
              heroTag: "game",
              onPressed: _openGamePanel,
              child: const Icon(Icons.casino),
            ),
          ),
        ],
      ),
    );
  }
}