import 'dart:io';
import 'package:responsive_dashboard/Method/ping_check_connection.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:udp/udp.dart';
import 'package:wake_on_lan/wake_on_lan.dart';

Future<void> PowerOnAllServer() async {
  allRoom.power_all_servers.setValue(true);
  for (Room room in rooms) {
    for (Server server in room.servers) {
      if (!server.power_status.getValue() && room.resolume) {
        server.power_status.setValue(true);
        WakeonLan(room,server);
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
        ShutdownServer(room,server);
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

Future<void> ShutdownServer(Room room, Server server) async {
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
  checkConnectionServerResponse(room,server);
}

// void WakeonLan(Room room, Server server, {int port = 9}) async {
//   server.power_status.setValue(true);
//
//   String ipv4 = server.ip;
//   String mac = server.mac_address.toUpperCase();
//   print(mac);
//   // Validate that the IP address is correctly formatted
//   final ipValidation = IPAddress.validate(ipv4);
//   if (!ipValidation.state) {
//     throw ipValidation.error!;
//   }
//
//   // Validate that the MAC address is correctly formatted
//   final macValidation = MACAddress.validate(mac);
//   if (!macValidation.state) {
//     throw macValidation.error!;
//   }
//   print(ipValidation.state.toString()+macValidation.state.toString());
//   // Create the IP and MAC addresses
//   IPAddress ipv4Address = IPAddress(ipv4);
//   MACAddress macAddress = MACAddress(mac);
//
//   // Send the Wake-on-LAN packet
//   WakeOnLAN(ipv4Address, macAddress).wake();
//
//   print("Starting wake server...");
//   await Future.delayed(Duration(seconds: 90));
//   print("90 seconds have passed!");
//   checkConnectionServer(room,server);
// }
Future<void> WakeonLan(Room room, Server server, {int port = 9}) async {
  server.power_status.setValue(true);
  // Validate MAC address format
  if (!RegExp(r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$').hasMatch(server.mac_address.toUpperCase())) {
    print('Invalid MAC address format');
    return;
  }

  // Convert MAC address from string to bytes
  List<int> macBytes = server.mac_address.split(':').map((e) => int.parse(e, radix: 16)).toList();

  // Create WOL packet
  List<int> packet = List<int>.filled(102, 0xFF);
  for (int i = 6; i < 102; i += 6) {
    packet.setRange(i, i + 6, macBytes);
  }

  // Send WOL packet
  try {
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 0).then((socket) {
      socket.broadcastEnabled = true;
      socket.send(packet, InternetAddress(server.ip), port);
      print('sent package'+packet.toString());
      socket.close();
    });
  } catch (e) {
    print('Error: $e');
  }

  print("Starting wake server...");
  await Future.delayed(Duration(seconds: 50));
  print("50 seconds have passed!");
  checkConnectionServer(room,server);
}
void WakeonLanOld(Room room, Server server, {int port = 9}) async {
  server.power_status.setValue(true);

  final boardcastIP = InternetAddress('255.255.255.255');
  final macBytes = _parseMacAddress(server.mac_address);

  final magicPacket = List<int>.generate(
      102, (index) => index < 6 ? 0xFF : macBytes[index % 6]);

  RawDatagramSocket.bind(InternetAddress.anyIPv4, 0).then((socket) {
    socket.broadcastEnabled = true;
    socket.send(magicPacket, boardcastIP, port);
    print('sent package');
    socket.close();
  });
  print("Starting wake server...");
  await Future.delayed(Duration(seconds: 30));
  print("30 seconds have passed!");
  checkConnectionServer(room,server);
}

List<int> _parseMacAddress(String macAddress) {
  final parts = macAddress.split(':');
  return List<int>.generate(
    6,
    (index) => int.parse(parts[index], radix: 16),
  );
}
