import 'dart:convert';
import 'dart:io';

import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:valuable/valuable.dart';

Future<void> sendPJLinkAuth(String username, String password) async {
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
String sendTCPIPCommand(Projector projector, String command) {
  String response='';
  try {
    Socket.connect(projector.ip, projector.port).then((socket) {
      print('Connected to ${socket.remoteAddress.address}:${socket.remotePort}');
      socket.write(command);
      socket.listen((data) {
        response = utf8.decode(data);
        print('Response: $response');
        if (response.contains('PWR!1')) {
          projector.power_status.setValue(true);
        } else if (response.contains('PWR!0')){
          projector.power_status.setValue(false);
        } else if (response.contains('SHU!01')){
          projector.shutter_status.setValue(true);
        } else if (response.contains('SHU!00')){
          projector.shutter_status.setValue(false);
        }
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
  return response;
}

String sendTCPIPCommand2(String ip , int port, String command) {
  String response='';
  try {
    Socket.connect(ip, port).then((socket) {
      print('Connected to ${socket.remoteAddress.address}:${socket.remotePort}');
      socket.write(command);
      socket.listen((data) {
        response = utf8.decode(data);
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
  return response;
}


String sendPJLinkCommand(Projector projector, String command) {
  String response='';
  try {
    Socket.connect(projector.ip, 4352).then((socket) {
      print('Connected to ${socket.remoteAddress.address}:${socket.remotePort}');
      socket.write(command);
      socket.listen((data) {
        response = utf8.decode(data);
        print('Response: $response');
        if (response.contains('PWR!1')) {
          projector.power_status.setValue(true);
        } else if (response.contains('PWR!0')){
          projector.power_status.setValue(false);
        } else if (response.contains('SHU!01')){
          projector.shutter_status.setValue(true);
        } else if (response.contains('SHU!00')){
          projector.shutter_status.setValue(false);
        }
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
  return response;
}

// // Sử dụng hàm sendPJLinkCommand() để gửi lệnh bật máy chiếu
// sendPJLinkCommand('(PWR 1)');
//
// // Sử dụng hàm sendPJLinkCommand() để gửi lệnh tắt máy chiếu
// sendPJLinkCommand('(PWR 0)');
