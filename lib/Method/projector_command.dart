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

String sendTCPIPCommandOnly(Projector projector, String command) {
  String response = '';
  Socket.connect(projector.ip, 3002).then((socket) {
    print('Connected to ${socket.remoteAddress.address}:${socket.remotePort}');
    socket.write(command);
    socket.listen((data) {
      response = utf8.decode(data);
      print('Response: ${projector.ip} $response');
      if (response.contains('PWR!03')) {
        projector.power_status.setValue(true);
        // projector.power_status_button.setValue(true);
      } else if (response.contains('PWR!01')) {
        projector.power_status.setValue(false);
        // projector.power_status_button.setValue(false);
      } else if (response.contains('SHU!01')) {
        projector.shutter_status.setValue(true);
        // projector.shutter_status_button.setValue(true);
      } else if (response.contains('SHU!00')) {
        projector.shutter_status.setValue(false);
        // projector.shutter_status_button.setValue(false);
      }
      socket.close();
    }, onDone: () {
      print('Connection closed');
    });
  }, onError: (error) {
  });
  return response;
}
// Hàm gửi lệnh bật/tắt máy chiếu
String sendTCPIPCommandStatus(Projector projector, String command) {
  String response = '';
  Socket.connect(projector.ip, 3002).then((socket) {
    socket.write(command);
    print('Sent to ${socket.remoteAddress.address}:${socket.remotePort}');
    socket.listen((data) async {
      response = utf8.decode(data);
      print('Response: ${projector.ip} $response');
      if (response.contains('PWR!01')) {
        projector.status.setValue(3);
        projector.power_status.setValue(false);
      } else if (response.contains('PWR!03')) {
        projector.status.setValue(1);
        projector.power_status.setValue(true);
      } else if (response.contains('PWR!04')) {
        if (projector.power_status.getValue()){
          projector.status.setValue(4);
        } else {
          projector.status.setValue(2);
        }
      } else if (response.contains('SHU!01')) {
        if (projector.power_status.getValue()){
          projector.status.setValue(5);
        } else {
          projector.status.setValue(6);
        }
        projector.shutter_status.setValue(true);
      } else if (response.contains('SHU!00')) {
        projector.shutter_status.setValue(false);
      }
      socket.close();
    }, onDone: () {
      print('Connection closed');
    });
  }, onError: (error) {
    projector.status.setValue(0);
    projector.connected.setValue(false);
    projector.power_status.setValue(false);
    projector.shutter_status.setValue(false);
    print('Error: Refused connection');
  });
  return response;
}

void sendTCPIPCommandNoResponse(Projector projector, String command) {
  try {
  Socket.connect(projector.ip, projector.port).then((socket) {
    socket.write(command);
    print('Sent to ${socket.remoteAddress.address}:${socket.remotePort}');
  });
  }
  catch (e) {
    print('Error');
  };
}

String sendPJLinkCommand(Projector projector, String command) {
  String response = '';
  try {
    Socket.connect(projector.ip, 4352).then((socket) {
      print(
          'Connected to ${socket.remoteAddress.address}:${socket.remotePort}');
      socket.write(command);
      socket.listen((data) {
        response = utf8.decode(data);
        print('Response: $response');
        if (response.contains('PWR!1')) {
          projector.power_status.setValue(true);
        } else if (response.contains('PWR!0')) {
          projector.power_status.setValue(false);
        } else if (response.contains('SHU!01')) {
          projector.shutter_status.setValue(true);
        } else if (response.contains('SHU!00')) {
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
