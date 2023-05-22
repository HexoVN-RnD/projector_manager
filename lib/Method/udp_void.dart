import 'dart:convert';
import 'dart:io';
import 'package:osc/osc.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:udp/udp.dart';

void SendUDPMessage(Server server, String message) async {
  try {
    final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 5000);
    socket.send(message.codeUnits, InternetAddress(server.ip), 5000);
    print(message);
    socket.close();
  } catch (e) {
    print(e);
  }
}

void SendUDPVolumeMessage(Server server, double index) async {
  try {
    final message = 'volume:' + ((index * 100).toInt()).toString();
    final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 5000);
    socket.send(message.codeUnits, InternetAddress(server.ip), 5000);
    print(message);
    socket.close();
  } catch (e) {
    print(e);
  }
}
