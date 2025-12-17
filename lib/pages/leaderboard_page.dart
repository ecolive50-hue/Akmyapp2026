import 'package:flutter/material.dart';
import '../models/leaderboard_model.dart';
import '../services/api_service.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🏆 Leaderboard")),
      body: FutureBuilder<List<LeaderboardModel>>(
        future: ApiService.getLeaderboard(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final list = snapshot.data!;
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, i) {
              final u = list[i];
              return ListTile(
                leading: CircleAvatar(
                  child: Text("${i + 1}"),
                ),
                title: Text(u.name),
                trailing: Text(
                  "💰 ${u.totalSpent}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            },
          );
        },
      ),
    );
  }
}