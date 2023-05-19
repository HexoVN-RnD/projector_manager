import 'dart:io';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/data/data.dart';

void PowerOnAllServer() {
  allRoom.power_all_servers.setValue(true);
  for (Room room in rooms){
    for (Server server in room.servers){
      server.power_status.setValue(true);
      WakeonLan(server);
    }
  }
  print('Power On All Server');
}
void ShutdownAllServer() {
  allRoom.power_all_servers.setValue(false);
  for (Room room in rooms){
    for (Server server in room.servers){
      server.power_status.setValue(false);
      ShutdownServer(server);
    }
  }
  print('Shutdown All Server');
}

void PowerModeServer(Server server) {
  server.power_status.setValue(!server.power_status.getValue());
  if (server.power_status.getValue()) {
    WakeonLan(server);
  } else {
    ShutdownServer(server);
  }
  print(server.mac_address);
}

void ShutdownServer(Server server){
  final message = 'shutdown' ;

  RawDatagramSocket.bind(InternetAddress.anyIPv4, 0).then((socket) {
    socket.send(message.codeUnits, InternetAddress(server.ip), server.power_port);
    socket.close();
  });
  print(message);
}

void WakeonLan(Server server, {int port = 9}) async {
  final boardcastIP = InternetAddress('255.255.255.255');
  final macBytes = _parseMacAddress(server.mac_address);

  final magicPacket = List<int>.generate(102, (index) => index < 6? 0xFF: macBytes[index %6]);

  RawDatagramSocket.bind(InternetAddress.anyIPv4, 0).then((socket) {
    socket.broadcastEnabled =true;
    socket.send(magicPacket, boardcastIP, port);
    socket.close();
  });
}

List<int> _parseMacAddress(String macAddress) {
  final parts = macAddress.split(':');
  return List<int>.generate(6, (index) => int.parse(parts[index], radix: 16),);
}


