import 'dart:convert';
import 'dart:io';

void sendPJLinkAuth(String username, String password) async {
  try {
    // Tạo kết nối socket tới địa chỉ và cổng của máy chiếu
    Socket socket = await Socket.connect('192.168.0.100', 4352);

    // Chuyển đổi lệnh xác thực thành chuỗi dữ liệu để gửi đi
    String data = '%AUTH $username $password\r';
    socket.write(data);

    // Đọc phản hồi từ máy chiếu
    String response = await utf8.decodeStream(socket);
    print('Phản hồi từ máy chiếu: $response');

    // Đóng kết nối socket
    socket.close();
  } catch (e) {
    print('Lỗi: $e');
  }
}

// Hàm gửi lệnh bật/tắt máy chiếu
void sendPJLinkCommand(String ip, int port, String command) async {
  try {
    Socket.connect(ip, port).then((socket) {
      print('Connected to ${socket.remoteAddress.address}:${socket.remotePort}');
      socket.write(command);
      socket.listen((data) {
        String response = utf8.decode(data);
        print('Response: $response');
        socket.close();
      }, onDone: () {
        print('Connection closed');
      });
    }, onError: (error) {
      print('Error: $error');
    });
  } catch (e) {
    print('Error: $e');
  }
}

// // Sử dụng hàm sendPJLinkCommand() để gửi lệnh bật máy chiếu
// sendPJLinkCommand('(PWR 1)');
//
// // Sử dụng hàm sendPJLinkCommand() để gửi lệnh tắt máy chiếu
// sendPJLinkCommand('(PWR 0)');
