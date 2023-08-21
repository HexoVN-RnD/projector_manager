import 'dart:io';
import 'package:responsive_dashboard/Method/ping_check_connection.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/data/data.dart';

Future<void> PowerOnAllServer() async {
  allRoom.power_all_servers.setValue(true);
  for (Room room in rooms) {
    for (Server server in room.servers) {
      if (!server.power_status.getValue() && room.resolume) {
        server.power_status.setValue(true);
        WakeonLan(server);
        await Future.delayed(Duration(seconds: 15));
      }
    }
  }
  print('Power On All Server');
  // await Future.delayed(Duration(seconds: 90));
  // print("90 seconds have passed!");
  // for (Room room in rooms){
  //   for (Server server in room.servers){
  //     checkConnectionServerResponse(server);
  //   }
  // }
}

Future<void> ShutdownAllServer() async {
  allRoom.power_all_servers.setValue(false);
  for (Room room in rooms) {
    for (Server server in room.servers) {
      if (server.power_status.getValue() && room.resolume) {
        server.power_status.setValue(false);
        ShutdownServer(server);
      }
    }
  }
  print('Shutdown All Server');
  // await Future.delayed(Duration(seconds: 30));
  // print("30 seconds have passed!");
  // for (Room room in rooms){
  //   for (Server server in room.servers){
  //     checkConnectionServerResponse(server);
  //   }
  // }
}

// Future<void> PowerModeServer(Server server, bool mode) async {
//   server.power_status.setValue(mode);
//   if (mode) {
//     WakeonLan(server);
//   } else {
//     ShutdownServer(server);
//   }
//   print(server.mac_address);
//   print("Starting...");
//   await Future.delayed(Duration(seconds: 90));
//   print("90 seconds have passed!");
//   checkConnectionServerResponse(server);
//
// }

Future<void> ShutdownServer(Server server) async {
  final message = 'shutdown';
  server.power_status.setValue(false);
  RawDatagramSocket.bind(InternetAddress.anyIPv4, 0).then((socket) {
    socket.send(
        message.codeUnits, InternetAddress(server.ip), server.power_port);
    socket.close();
  });
  print(message);
  print("Starting...");
  await Future.delayed(Duration(seconds: 30));
  print("30 seconds have passed!");
  checkConnectionServerResponse(server);
}

void WakeonLan(Server server, {int port = 9}) async {
  server.power_status.setValue(true);

  final boardcastIP = InternetAddress('255.255.255.255');
  final macBytes = _parseMacAddress(server.mac_address);

  final magicPacket = List<int>.generate(
      102, (index) => index < 6 ? 0xFF : macBytes[index % 6]);

  RawDatagramSocket.bind(InternetAddress.anyIPv4, 0).then((socket) {
    socket.broadcastEnabled = true;
    socket.send(magicPacket, boardcastIP, port);
    socket.close();
  });
  print("Starting wake server...");
  await Future.delayed(Duration(seconds: 90));
  print("90 seconds have passed!");
  checkConnectionServer(server);
}

List<int> _parseMacAddress(String macAddress) {
  final parts = macAddress.split(':');
  return List<int>.generate(
    6,
    (index) => int.parse(parts[index], radix: 16),
  );
}
