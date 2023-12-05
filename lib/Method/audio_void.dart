import 'dart:io';
import 'package:osc/osc.dart';
import 'package:responsive_dashboard/Method/Osc_void.dart';
import 'package:responsive_dashboard/Method/excel.dart';
import 'package:responsive_dashboard/Method/udp_void.dart';
import 'package:responsive_dashboard/Object/BrightSign.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';

// void EditAllAudio(index) {
//   allRoom.volume_all.setValue(index);
//   // writeCellValue(index.toStringAsFixed(2), 0, 1);
//   for (Room room in rooms) {
//     if (room.resolume) {
//       for (Server server in room.servers) {
//         server.volume.setValue(index);
//       }
//     } else {
//       for (Server server in room.servers) {
//         server.volume.setValue(index);
//       }
//     }
//   }
// }
// void EditAllAudioAndSave(index) {
//   allRoom.volume_all.setValue(index);
//   // writeTableValue(index.toStringAsFixed(2));
//   // writeCellValue(index.toStringAsFixed(2), 0, 1);
//   for (Room room in rooms) {
//     if (room.resolume) {
//       for (Server server in room.servers) {
//         server.volume.setValue(index);
//         // writeCellValue(index.toStringAsFixed(2), server.id, 1);
//         SendOscMessage(server.ip, server.preset_port,
//             '/composition/layers/1/audio/volume', [index]);
//         SendOscMessage(server.ip, server.preset_port,
//             '/composition/layers/2/audio/volume', [index]);
//         SendOscMessage(server.ip, server.preset_port,
//             '/composition/layers/3/audio/volume', [index]);
//         SendOscMessage(server.ip, server.preset_port,
//             '/composition/layers/4/audio/volume', [index]);
//       }
//     } else {
//       for (Server server in room.servers) {
//         server.volume.setValue(index);
//         SendUDPAudioMessage(server, index);
//       }
//     }
//   }
// }


void SendAudioOSC(Room room, double index) async {
  // writeCellValue(index.toStringAsFixed(2), server.id, 1);
  // print('Setaudio');
  for (Server server in room.servers!) {
    SendOscMessage(
        server.ip, server.preset_port, '/composition/layers/1/audio/volume',
        [index]);
    SendOscMessage(
        server.ip, server.preset_port, '/composition/layers/2/audio/volume',
        [index]);
    SendOscMessage(
        server.ip, server.preset_port, '/composition/layers/3/audio/volume',
        [index]);
    SendOscMessage(
        server.ip, server.preset_port, '/composition/layers/4/audio/volume',
        [index]);
  }
  // await prefs.setDouble('volume', volume);
}

void SendUDPAudioMessage(BrightSign brighSign, double index) async {
  // print('Setaudio: ${current_page.getValue()}');
  try {
    final message = 'volume:' + ((index * 100).toInt()).toString();
    // writeCellValue(index.toStringAsFixed(2), server.id, 1);
    final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 5000);
    socket.send(message.codeUnits, InternetAddress(brighSign.ip), 5000);
    // print(message);
    socket.close();
  } catch (e) {
    print(e);
  }
}