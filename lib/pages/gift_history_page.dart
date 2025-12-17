import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/gift_model.dart';

class GiftHistoryPage extends StatelessWidget {
  final String roomId;
  const GiftHistoryPage({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gift History")),
      body: FutureBuilder<List<GiftModel>>(
        future: ApiService.getGiftHistory(roomId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final gifts = snapshot.data!;
          return ListView.builder(
            itemCount: gifts.length,
            itemBuilder: (_, i) {
              final g = gifts[i];
              return ListTile(
                leading: Text(g.emoji, style: const TextStyle(fontSize: 28)),
                title: Text(g.name),
                trailing: Text("+${g.price}"),
              );
            },
          );
        },
      ),
    );
  }
}