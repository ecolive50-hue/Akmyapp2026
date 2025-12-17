import 'socket_service.dart';

class GiftService {
  final socket = SocketService();

  void sendGift({
    required String roomId,
    required String fromUser,
    required String toUser,
    required String giftId,
    required int price,
  }) {
    socket.socket.emit("send-gift", {
      "roomId": roomId,
      "from": fromUser,
      "to": toUser,
      "giftId": giftId,
      "price": price,
    });
  }
}