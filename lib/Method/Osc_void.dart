import 'dart:convert';
import 'dart:io';
import 'package:osc/osc.dart';
import 'package:responsive_dashboard/Method/udp_void.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udp/udp.dart';



void SendOscMessage(
    String ip, int port, String oscAddress, List<Object> oscParameters) async {
  try {
    final remoteIP = InternetAddress(ip); // Địa chỉ IP của máy chủ OSC
    final udp = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
    final oscMessage = OSCMessage(oscAddress, arguments: oscParameters);
    final oscData = oscMessage.toBytes();

    // Send message
    udp.send(oscData, remoteIP, port);
    print('Sent $oscMessage to $remoteIP at port: $port');

    // Đóng kết nối UDP
    udp.close();
  } catch (e) {
    print('Error cant send OSC message');
  }
}

void SendPresetOSC(String ip, int port, int column) async {
  column += 1;
  SendOscMessage(ip, port, '/composition/columns/$column/connect', [1]);
}

void SelectAllPreset(index) {
  allRoom.current_preset.setValue(index);
  for (Room room in rooms) {
    if (index<room.presets.length) {
      room.current_preset.setValue(index);
      for (Server server in room.servers) {
        if (room.resolume) {
          SendPresetOSC(
              server.ip, server.preset_port, room.current_preset.getValue());
        } else {
          SendUDPMessage(
              server, 'Preset' + room.current_preset.getValue().toString());
        }
      }
    } else {
      room.current_preset.setValue(room.presets.length-1);
      for (Server server in room.servers) {
        if (room.resolume) {
          SendPresetOSC(
              server.ip, server.preset_port, room.current_preset.getValue());
        } else {
          SendUDPMessage(
              server, 'Preset' + room.current_preset.getValue().toString());
        }
      }
    }

  }
}


void OSCReceive(Room room, Server server) async {
  try {
    // final socket =OSCSocket( serverAddress: InternetAddress(server.ip), serverPort: 7001)
    final socket =
        await RawDatagramSocket.bind(InternetAddress(server.ip), 7001);
    // Đặt cổng lắng nghe OSC (ví dụ: 7001)
    OSCMessage oscMessage;
    socket.listen((event) {
      if (event == RawSocketEvent.read) {
        final datagram = socket.receive();
        if (datagram != null && room.presets.length >= room.current_preset.getValue()) {
          if (!server.connected.getValue()) {
            server.connected.setValue(true);
          }

          oscMessage = OSCMessage.fromBytes(datagram.data);

          double transport =
              double.tryParse(oscMessage.arguments[0].toString()) ?? 0.0;
          if (room.presets[room.current_preset.getValue()].transport
                  .getValue() <=
              1) {
            room.presets[room.current_preset.getValue()].transport
                .setValue(transport);
          }
          print('Argument value: ' + transport.toString());
        }
      }
    });
  } catch (e) {
    print(e);
  }
}
