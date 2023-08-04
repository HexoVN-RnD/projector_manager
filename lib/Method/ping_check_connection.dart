import 'dart:io';

import 'package:dart_ping/dart_ping.dart';
import 'package:responsive_dashboard/Method/Control_projector_void.dart';
import 'package:responsive_dashboard/Method/networkAddress.dart';
import 'package:responsive_dashboard/Method/projector_command.dart';
import 'package:responsive_dashboard/Method/projector_void.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/Sensor.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:valuable/valuable.dart';

void checkConnectionServer(Server server) {

  int count = 0;
  final ping = Ping(server.ip, count: 1); // Thay đổi số lần ping tùy ý

  ping.stream.listen((event) {
    print('ping server ${server.ip} response ${event.response?.time} ${count}');
    // print('Ping to ${server.ip}: ${event.response?.time} ms');
    if (event.response?.time != null) {
      server.connected.setValue(true);
      // server.power_status.setValue(true);
    } else if (event.response?.time == null && count != 1) {
      server.connected.setValue(false);
      // server.power_status.setValue(false);
      // print('ping server ${event.response?.ip} ${count}');
    }
    count++;
  });
  ping.command;
}
void checkConnectionServerResponse(Server server) {

  int count = 0;
  final ping = Ping(server.ip, count: 1); // Thay đổi số lần ping tùy ý

  ping.stream.listen((event) {
    print('ping server ${server.ip} response ${event.response?.time} ${count}');
    // print('Ping to ${server.ip}: ${event.response?.time} ms');
    if (event.response?.time != null) {
      server.connected.setValue(true);
      server.power_status.setValue(true);
    } else if (event.response?.time == null && count != 1) {
      server.connected.setValue(false);
      server.power_status.setValue(false);
      // print('ping server ${event.response?.ip} ${count}');
    }
    count++;
  });
  ping.command;
}

void checkConnectionSensor(Sensor sensor) {
  int count = 0;
  final ping = Ping(sensor.ip, count: 1); // Thay đổi số lần ping tùy ý
  ping.stream.listen((event) {
    print('ping sensor ${sensor.ip}: response ${event.response?.time} ${count}');
    // print('Ping to ${sensor.ip}: ${event.response?.time} ms');
    if (event.response?.time != null) {
      sensor.connected.setValue(true);
    } else if (event.response?.ip == null && count != 1) {
        sensor.connected.setValue(false);
        // print('Error');
    }
    count++;
    // ping.stop();
  }, onError: (error) {
    print(error);
  });
  ping.command;
}

void checkConnectionProjector(Projector projector) {
  int count=0;
  final ping = Ping(projector.ip, count: 1); // Thay đổi số lần ping tùy ý

  ping.stream.listen((event) {
    print('Ping to ${projector.ip}: ${event.response?.time} ms');
    if (event.response?.time != null) {
      projector.connected.setValue(true);
      ping.stop();
    } else if (event.response?.ip == null && count != 1) {
      projector.connected.setValue(false);
      // print('Error');
    }
    count++;
  });
  ping.command;
}

Future<void> checkRoomConnection(Room room) async {
  // if (!room.servers.isEmpty)
  //   for (Server server in room.servers) {
  //     checkConnectionServer(server);
  //   }
  // if (!room.sensors.isEmpty) {
  //   for (Sensor sensor in room.sensors) {
  //     checkConnectionSensor(sensor);
  //   }
  // }
  if (!room.projectors.isEmpty) {
    RoomStatus(room);
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
//     22,
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
//   const port = 22;
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
