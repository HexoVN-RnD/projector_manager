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

void SendPlayOSC(String ip, int port, int column) async {
  SendOscMessage(
      ip,
      port,
      '/composition/layers/1/clips/${column + 1}/transport/position/behaviour/playdirection',
      [2]);
  SendOscMessage(
      ip,
      port,
      '/composition/layers/2/clips/${column + 1}/transport/position/behaviour/playdirection',
      [2]);
}

void SendStopOSC(String ip, int port, int column) async {
  SendOscMessage(
      ip,
      port,
      '/composition/layers/1/clips/${column + 1}/transport/position/behaviour/playdirection',
      [1]);
  SendOscMessage(
      ip,
      port,
      '/composition/layers/2/clips/${column + 1}/transport/position/behaviour/playdirection',
      [1]);
}

void SelectAllPreset(index) {
  allRoom.current_preset.setValue(index);
  for (Room room in rooms) {
    if (index < room.presets.length) {
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
      room.current_preset.setValue(room.presets.length - 1);
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

void PlayPreset(int index) {
  switch (index) {
    case 1:
      for (Server server in rooms[0].servers) {
        SendUDPMessage(server, 'Preset'+(rooms[index-1].current_preset.getValue()+1).toString());
      }
      break;
    case 2:
      SendPlayOSC(rooms[1].servers[0].ip, rooms[1].servers[0].preset_port,
          allRoom.current_preset.getValue());
      SendPlayOSC(rooms[1].servers[1].ip, rooms[1].servers[1].preset_port,
          allRoom.current_preset.getValue());
      break;
    case 3:
      SendPresetOSC(rooms[2].servers[1].ip, rooms[2].servers[1].preset_port, 0);
      break;
    case 4:
      SendUDPMessage(rooms[3].servers[0], 'Preset'+(rooms[index-1].current_preset.getValue()+1).toString());
      SendUDPMessage(rooms[3].servers[1], 'Preset'+(rooms[index-1].current_preset.getValue()+1).toString());
  }
}void StopPreset(int index) {
  switch (index) {
    case 1:
      for (Server server in rooms[0].servers) {
        SendUDPMessage(server, 'Preset0');
      }
      break;
    case 2:
      SendStopOSC(rooms[1].servers[0].ip, rooms[1].servers[0].preset_port,
          allRoom.current_preset.getValue());
      SendStopOSC(rooms[1].servers[1].ip, rooms[1].servers[1].preset_port,
          allRoom.current_preset.getValue());
      break;
    case 3:
      SendPresetOSC(rooms[2].servers[1].ip, rooms[2].servers[1].preset_port, 1);
      break;
    case 4:
      SendUDPMessage(rooms[3].servers[0], 'Preset0');
      SendUDPMessage(rooms[3].servers[1], 'Preset0');
  }
}

void PlayAllPreset() {
  for (Server server in rooms[0].servers) {
    SendUDPMessage(server, 'Preset0');
  }
  SendPlayOSC(rooms[1].servers[0].ip, rooms[1].servers[0].preset_port,
      allRoom.current_preset.getValue());
  SendPlayOSC(rooms[1].servers[1].ip, rooms[1].servers[1].preset_port,
      allRoom.current_preset.getValue());
  SendPresetOSC(rooms[2].servers[1].ip, rooms[2].servers[1].preset_port, 0);
  SendUDPMessage(rooms[3].servers[0], 'Preset0');
  SendUDPMessage(rooms[3].servers[1], 'Preset0');
}

void StopAllPreset() {
  for (Server server in rooms[0].servers) {
    SendUDPMessage(server, 'Preset1');
  }
  SendStopOSC(rooms[1].servers[0].ip, rooms[1].servers[0].preset_port,
      allRoom.current_preset.getValue());
  SendStopOSC(rooms[1].servers[1].ip, rooms[1].servers[1].preset_port,
      allRoom.current_preset.getValue());
  SendPresetOSC(rooms[2].servers[1].ip, rooms[2].servers[1].preset_port, 1);
  SendUDPMessage(rooms[3].servers[0], 'Preset1');
  SendUDPMessage(rooms[3].servers[1], 'Preset1');
}

void OSCReceive() async {
  try {
    // final socket = await OSCSocket( serverAddress: InternetAddress(server.ip), serverPort: 7001);
    final socket =
        // await RawDatagramSocket.bind(InternetAddress.anyIPv4, 7001);
        await RawDatagramSocket.bind(InternetAddress('192.168.1.241'), 7001);
    // Đặt cổng lắng nghe OSC (ví dụ: 7001)
    OSCMessage oscMessage;
    socket.listen((event) {
      if (event == RawSocketEvent.read) {
        final datagram = socket.receive();
        if (datagram != null) {
          oscMessage = OSCMessage.fromBytes(datagram.data);

          double transport =
              double.tryParse(oscMessage.arguments[0].toString()) ?? 0.0;
          // if (allRoom.presets[allRoom.current_preset.getValue()].transport
          //         .getValue() <=
          //     1) {
          if (allRoom.presets.length > allRoom.current_preset.getValue()) {
            allRoom.presets[allRoom.current_preset.getValue()].transport
                .setValue(transport);
          }
          if (rooms[1].presets.length > rooms[1].current_preset.getValue()) {
            rooms[1]
                .presets[rooms[1].current_preset.getValue()]
                .transport
                .setValue(transport);
          }
          // }
          // print('Argument value: ' + rooms[1].presets[rooms[1].current_preset.getValue()].transport
          //     .getValue().toString());
        }
      }
    });
  } catch (e) {
    print(e);
  }
}
