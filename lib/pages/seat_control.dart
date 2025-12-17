import 'package:flutter/material.dart';

class SeatControlPage extends StatelessWidget {
  final bool isHost;

  const SeatControlPage({super.key, required this.isHost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seat Control"),
      ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(child: Text("${index + 1}")),
            title: Text("Seat ${index + 1}"),
            subtitle: const Text("Empty"),
            trailing: isHost
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.mic),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {},
                      ),
                    ],
                  )
                : ElevatedButton(
                    onPressed: () {},
                    child: const Text("Request"),
                  ),
          );
        },
      ),
    );
  }
}