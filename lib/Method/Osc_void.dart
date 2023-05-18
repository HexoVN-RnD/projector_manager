import 'dart:convert';
import 'dart:io';
import 'package:osc/osc.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:udp/udp.dart';

void SendOscMessage(
    String ip, int port, String oscAddress, List<Object> oscParameters) async {
  final remoteIP = InternetAddress(ip); // Địa chỉ IP của máy chủ OSC
  final udp = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
  final oscMessage = OSCMessage(oscAddress, arguments: oscParameters);
  final oscData = oscMessage.toBytes();

  // Send message
  udp.send(oscData, remoteIP, port);
  print('Sent $oscMessage to $remoteIP at port: $port');

  // Đóng kết nối UDP
  udp.close();
}

void SendAudioOSC(String ip, int port, List<Object> oscParameters) async {
  SendOscMessage(ip, port, '/composition/layers/1/audio/volume', oscParameters);
  SendOscMessage(ip, port, '/composition/layers/2/audio/volume', oscParameters);
  SendOscMessage(ip, port, '/composition/layers/3/audio/volume', oscParameters);
}

void SendPresetOSC(String ip, int port, int column) async {
  column += 1;
  SendOscMessage(ip, port, '/composition/columns/$column/connect', [1]);
}

void SelectAllPresetOSC(index) {
  allRoom.current_preset.setValue(index);
  for (Room room in rooms) {
    room.current_preset.setValue(index);
    for (Server server in room.servers) {
      final column = index + 1;
      SendOscMessage(
          server.ip, server.port, '/composition/columns/$column/connect', [1]);
    }
  }
}

void EditAllAudioOSC(index) {
  allRoom.volume_all.setValue(index);
  for (Room room in rooms) {
    for (Server server in room.servers) {
      server.volume.setValue(index);
      SendOscMessage(server.ip, server.port,
          '/composition/layers/1/audio/volume', [index]);
      SendOscMessage(server.ip, server.port,
          '/composition/layers/2/audio/volume', [index]);
      SendOscMessage(server.ip, server.port,
          '/composition/layers/3/audio/volume', [index]);
    }
  }
}

void OSCReceive(Room room, String ip, int port) async {
  final socket = await RawDatagramSocket.bind(InternetAddress('127.0.0.1'),
      7001); // Đặt cổng lắng nghe OSC (ví dụ: 7001)
  OSCMessage oscMessage;
  socket.listen((event) {
    if (event == RawSocketEvent.read) {
      final datagram = socket.receive();
      if (datagram != null) {
        oscMessage = OSCMessage.fromBytes(datagram.data);
        if (room.current_preset.getValue() < 10) {
          if (room.presets[room.current_preset.getValue()].transport
                  .getValue() <= 1) {
            room.presets[room.current_preset.getValue()].transport.setValue(
                double.tryParse(oscMessage.arguments[0].toString()) ?? 0.0);
          }
        }
        print('Argument value: ' + oscMessage.arguments[0].toString());
      }
    }
  });
}

void sendUDPMessage() async {
  final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);

  // Địa chỉ IP và cổng của máy chủ hoặc thiết bị mà bạn muốn gửi tin nhắn tới
  final remoteIP = InternetAddress('192.168.2.75');
  final remotePort = 7000;

  final message = '/composition/layers/1/audio/volume';

  socket.send(message.codeUnits, remoteIP, remotePort);

  socket.close();
  print(remoteIP);
}
