import 'dart:io';

import 'package:dart_ping/dart_ping.dart';
import 'package:responsive_dashboard/Method/networkAddress.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/Sensor.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:valuable/valuable.dart';

void checkConnectionServer(String ip, StatefulValuable<bool> connected,
    StatefulValuable<bool> button) {
  // serverIP = '192.168.1.15';
  final ping = Ping(ip, count: 3); // Thay đổi số lần ping tùy ý

  ping.stream.listen((event) {
    print('Ping to $ip: ${event.response?.time} ms');
    if (event.response?.time != null) {
      connected.setValue(true);
      button.setValue(true);
      ping.stop();
    } else {
      Socket.connect(ip, 1234).then((socket) {}, onError: (error) {
        connected.setValue(false);
        button.setValue(false);
        print('Error');
      });
    }
  });
  ping.command;
}

void checkConnectionSensor(String ip, StatefulValuable<bool> connected) {
  // serverIP = '192.168.1.15';
  final ping = Ping(ip, count: 3); // Thay đổi số lần ping tùy ý

  ping.stream.listen((event) {
    print('Ping to $ip: ${event.response?.time} ms');
    if (event.response?.time != null) {
      connected.setValue(true);
      ping.stop();
    } else {
      Socket.connect(ip, 9999).then((socket) {}, onError: (error) {
        connected.setValue(false);
        print('Error');
      });
    }
  });
  ping.command;
}

void checkConnectionProjector(Projector projector) {
  // serverIP = '192.168.1.15';
  final ping = Ping(projector.ip, count: 3); // Thay đổi số lần ping tùy ý

  ping.stream.listen((event) {
    print('Ping to ${projector.ip}: ${event.response?.time} ms');
    if (event.response?.time != null) {
      projector.connected.setValue(true);
      ping.stop();
    } else {
      Socket.connect(projector.ip, 3002).then((socket) {}, onError: (error) {
        projector.connected.setValue(false);
        projector.power_status.setValue(false);
        projector.power_status_button.setValue(false);
        projector.shutter_status.setValue(false);
        projector.shutter_status_button.setValue(false);
      });
    }

  });
  ping.command;

}

void checkRoomConnection(Room room) {
  if (!room.servers.isEmpty)
    for (Server server in room.servers) {
      // serverIP = '192.168.1.15';
      final ping = Ping(server.ip, count: 3); // Thay đổi số lần ping tùy ý

      ping.stream.listen((event) {
        print('Ping to ${server.ip}: ${event.response?.time} ms');
        if (event.response?.time != null) {
          server.connected.setValue(true);
          server.power_status.setValue(true);
          print('Connected');
          ping.stop();
        } else {
          Socket.connect(server.ip, 1234).then((socket) {}, onError: (error) {
            server.connected.setValue(false);
            server.power_status.setValue(false);
            print('Error');
          });
        }
      });
      ping.command;
    }
  if (!room.sensors.isEmpty) {
    for (Sensor sensor in room.sensors) {
      // serverIP = '102.168.1.15';
      final ping = Ping(sensor.ip, count: 3); // Thay đổi số lần ping tùy ý

      ping.stream.listen((event) {
        print('Ping to ${sensor.ip}: ${event.response?.time} ms');
        if (event.response?.time != null) {
          sensor.connected.setValue(true);
          print('Connected');
          ping.stop();
        } else {
          Socket.connect(sensor.ip, 9999).then((socket) {}, onError: (error) {
            sensor.connected.setValue(false);
            print('Error');
          });
        }
      });
      ping.command;
    }
  }
  if (!room.projectors.isEmpty) {
    for (Projector projector in room.projectors) {
      // serverIP = '192.168.1.15';
      final ping = Ping(projector.ip, count: 3); // Thay đổi số lần ping tùy ý

      ping.stream.listen((event) {
        print('Ping to ${projector.ip}: ${event.response?.time} ms');
        if (event.response?.time != null) {
          projector.connected.setValue(true);
          print('Connected');
          ping.stop();
        } else {
          Socket.connect(projector.ip, 3002).then((socket) {}, onError: (error) {
            projector.connected.setValue(false);
            projector.power_status.setValue(false);
            projector.power_status_button.setValue(false);
            projector.shutter_status.setValue(false);
            projector.shutter_status_button.setValue(false);
          });
        }

      });
      ping.command;
    }
  }
}

// void CheckConnectStatus(String ip) async {
//   try{
//     final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
//     socket.broadcastEnabled = true;
//
//     // Gửi dữ liệu qua socket UDP đến server
//     socket.send('ping'.codeUnits, InternetAddress('192.168.3.108'), 0);
//
//     // Đặt thười gian chờ để nhận phản hồi từ server
//     socket.timeout(Duration(seconds: 5));
//
//     //Lắng nghe phản hồi từ server
//     final response = await socket.receive();
//
//     //Kiểm tra phản hồi từ server
//     if(response!=null){
//       print(ip+ 'true');
//     } else {
//       print(ip+ ' false');
//     }
//
//   } catch (e){
//     print('Lỗi kiểm tra kết nối với server: $e');
//   }
// }
//
//
//
// void CheckAllConnectionOpening() {
//   print(current_page.getValue());
// }
//
// void CheckRoomConnection() {
//   print(current_page.getValue());
// }
//
// Future<void> check_connection2(String ip, StatefulValuable<bool> connection) async {
//   try {
//     final socket = await Socket.connect(ip, 1000);
//     print('connected');
//     socket.destroy();
//   } catch (e){
//     print('Failed to connect: $e');
//   }
// }
//
//
// void check_connection(String ip, StatefulValuable<bool> connection) {
//   // NetworkAnalyzer.discover pings PORT:IP one by one according to timeout.
//   // NetworkAnalyzer.discover2 pings all PORT:IP addresses at once.
//   final stream = NetworkAnalyzer.discover2(
//     ip,
//     80,
//     timeout: Duration(milliseconds: 5000),
//   );
//   print('Check Connecting...');
//   stream.listen((NetworkAddress addr) {
//     // print('${addr.ip}');
//     if (addr.exists) {
//       connection.setValue(true);
//       print('Found device: ${addr.ip}');
//     }
//   }).onDone(() => print('Finish'));
// }
//
// void check_all_connection(String subnet) {
//   // NetworkAnalyzer.discover pings PORT:IP one by one according to timeout.
//   // NetworkAnalyzer.discover2 pings all PORT:IP addresses at once.
//
//   const port = 80;
//   final stream = NetworkAnalyzer.discover_all(
//     subnet,
//     port,
//     timeout: Duration(milliseconds: 5000),
//   );
//
//   int found = 0;
//   stream.listen((NetworkAddress addr) {
//     // print('${addr.ip}:$port');
//     if (addr.exists) {
//       found++;
//       print('Found device: ${addr.ip}:$port');
//     }
//   }).onDone(() => print('Finish. Found $found device(s)'));
// }
