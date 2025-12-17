import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class ApiService {
  // 🔗 Backend URL
  static const String baseUrl =
      "https://backend-1-cy1j.onrender.com";

  // 👤 Create / Get User Profile
  static Future<UserModel> getProfile(
      String userId, String name) async {
    final res = await http.post(
      Uri.parse("$baseUrl/user"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "userId": userId,
        "name": name,
      }),
    );

    return UserModel.fromJson(jsonDecode(res.body));
  }

  // 💰 Add Coins
  static Future<int> addCoins(String userId, int amount) async {
    final res = await http.post(
      Uri.parse("$baseUrl/add-coins"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "userId": userId,
        "amount": amount,
      }),
    );

    return jsonDecode(res.body)['coins'];
  }
}