import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class ProfilePage extends StatefulWidget {
  final String userId;
  final String name;

  const ProfilePage({
    super.key,
    required this.userId,
    required this.name,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    user = await ApiService.getProfile(
      widget.userId,
      widget.name,
    );
    setState(() {});
  }

  void _addCoins() async {
    final coins = await ApiService.addCoins(widget.userId, 100);
    setState(() {
      user = UserModel(
        userId: user!.userId,
        name: user!.name,
        coins: coins,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("My Profile")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
          const SizedBox(height: 10),
          Text(user!.name, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 10),
          Text("Coins: ${user!.coins}",
              style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _addCoins,
            child: const Text("Add 100 Coins (Demo)"),
          )
        ],
      ),
    );
  }
}