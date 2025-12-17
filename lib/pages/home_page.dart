import 'package:flutter/material.dart';
import 'create_room_page.dart';
import 'voice_room_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Voice Live'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CreateRoomPage(),
                ),
              );
            },
            child: const Text('🎙️ Create Voice Room'),
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 10),
          const Text(
            'Public Rooms (Demo)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // Demo Room
          ListTile(
            leading: const Icon(Icons.mic),
            title: const Text('Room 1234'),
            subtitle: const Text('Tap to Join'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const VoiceRoomPage(
                    roomId: '1234',
                    isHost: false,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}