import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  late IO.Socket socket;

  void connect(String userId, String roomId) {
    socket = IO.io(
      "https://chat-backend3-ilk2.onrender.com",
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      socket.emit("join-room", {
        "roomId": roomId,
        "userId": userId,
      });
    });
  }

  void takeSeat(String roomId, int seatIndex, String userId) {
    socket.emit("take-seat", {
      "roomId": roomId,
      "seatIndex": seatIndex,
      "userId": userId,
    });
  }

  void leaveSeat(String roomId, String userId) {
    socket.emit("leave-seat", {
      "roomId": roomId,
      "userId": userId,
    });
  }

  void lockSeat(String roomId, int seatIndex) {
    socket.emit("lock-seat", {
      "roomId": roomId,
      "seatIndex": seatIndex,
    });
  }

  void onRoomState(Function(dynamic) callback) {
    socket.on("room-state", callback);
  }
}