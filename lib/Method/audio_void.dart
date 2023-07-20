import 'dart:io';
import 'package:osc/osc.dart';
import 'package:responsive_dashboard/Method/Osc_void.dart';
import 'package:responsive_dashboard/Method/excel.dart';
import 'package:responsive_dashboard/Method/udp_void.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/data/data.dart';

void EditAllAudio(index) {
  allRoom.volume_all.setValue(index);
  writeCellValue(index.toStringAsFixed(2), 0, 1);
  for (Room room in rooms) {
    if (room.resolume) {
      for (Server server in room.servers) {
        server.volume.setValue(index);
        writeCellValue(index.toStringAsFixed(2), server.id, 1);
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
        SendUDPAudioMessage(server, index);
      }
    }
  }
}

void SendAudioOSC(Server server, double index) async {
  writeCellValue(index.toStringAsFixed(2), server.id, 1);
  SendOscMessage(server.ip, server.preset_port, '/composition/layers/1/audio/volume', [index]);
  SendOscMessage(server.ip, server.preset_port, '/composition/layers/2/audio/volume', [index]);
  SendOscMessage(server.ip,server.preset_port, '/composition/layers/3/audio/volume', [index]);
  // await prefs.setDouble('volume', volume);
}

void SendUDPAudioMessage(Server server, double index) async {
  try {
    final message = 'volume:' + ((index * 100).toInt()).toString();
    writeCellValue(index.toStringAsFixed(2), server.id, 1);
    final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 5000);
    socket.send(message.codeUnits, InternetAddress(server.ip), 5000);
    print(message);
    socket.close();
  } catch (e) {
    print(e);
  }
}