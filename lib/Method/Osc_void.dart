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

void SendAudioOSC(String ip, int port, List<Object> oscParameters) async {
  SendOscMessage(ip, port, '/composition/layers/1/audio/volume', oscParameters);
  SendOscMessage(ip, port, '/composition/layers/2/audio/volume', oscParameters);
  SendOscMessage(ip, port, '/composition/layers/3/audio/volume', oscParameters);
  // await prefs.setDouble('volume', volume);
}

void SendPresetOSC(String ip, int port, int column) async {
  column += 1;
  SendOscMessage(ip, port, '/composition/columns/$column/connect', [1]);
}

void SelectAllPreset(index) {
  allRoom.current_preset.setValue(index);
  for (Room room in rooms) {
    room.current_preset.setValue(index);
    if (room.resolume) {
      for (Server server in room.servers) {
        final column = index + 1;
        SendOscMessage(server.ip, server.preset_port,
            '/composition/columns/$column/connect', [1]);
      }
    } else {
      for (Server server in room.servers) {
        SendUDPMessage(server, 'Preset' + index.toString());
      }
    }
  }
}

void EditAllAudio(index) {
  allRoom.volume_all.setValue(index);
  for (Room room in rooms) {
    if (room.resolume) {
      for (Server server in room.servers) {
        server.volume.setValue(index);
        SendOscMessage(server.ip, server.preset_port,
            '/composition/layers/1/audio/volume', [index]);
        SendOscMessage(server.ip, server.preset_port,
            '/composition/layers/2/audio/volume', [index]);
        SendOscMessage(server.ip, server.preset_port,
            '/composition/layers/3/audio/volume', [index]);
      }
    } else {
      for (Server server in room.servers) {
        server.volume.setValue(index);
        SendUDPVolumeMessage(server, index);
      }
    }
  }
}

void OSCReceive(Room room, Server server) async {
  try {
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
