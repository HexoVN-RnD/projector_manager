import 'dart:io';
import 'package:osc/osc.dart';
import 'package:responsive_dashboard/Method/udp_void.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';

void SendOscMessage(
    String ip, int port, String oscAddress, List<Object> oscParameters) async {
  try {
    final remoteIP = InternetAddress(ip); // Địa chỉ IP của máy chủ OSC
    final udp = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
    final oscMessage = OSCMessage(oscAddress, arguments: oscParameters);
    final oscData = oscMessage.toBytes();

    // Send message
    udp.send(oscData, remoteIP, port);
    ////print('Sent $oscMessage to $remoteIP at port: $port');

    // Đóng kết nối UDP
    udp.close();
  } catch (e) {
    ////print('Error cant send OSC message');
  }
}

void SendPresetOSC(String ip, int port, int column) async {
  column += 1;
  SendOscMessage(ip, port, '/composition/columns/$column/connect', [1]);
}

void SendPlayOSC(String ip, int port, int column) async {
  for (int i = 1; i < 5; i++) {
    SendOscMessage(
        ip,
        port,
        '/composition/layers/$i/clips/${column + 1}/transport/position/behaviour/playdirection',
        [2]);
  }
}

void SendStopOSC(String ip, int port, int column) async {
  for (int i = 1; i < 5; i++) {
    SendOscMessage(
        ip,
        port,
        '/composition/layers/$i/clips/${column + 1}/transport/position/behaviour/playdirection',
        [1]);
  }
}

void PlayPreset(int index) {
  switch (index) {
    case 2:
      for (Server server in rooms[1].servers) {
        SendUDPMessage(server,
            'Preset' + (rooms[1].current_preset.getValue() + 1).toString());
      }
      break;
    case 3:
      if (rooms[2].resolume) {
        SendPlayOSC(rooms[2].servers[0].ip, rooms[2].servers[0].preset_port,
            rooms[2].current_preset.getValue());
      } else {
        SendUDPMessage(rooms[2].servers[0], 'Preset1');
      }
      break;
    case 4:
      SendPlayOSC(rooms[3].servers[0].ip, rooms[3].servers[0].preset_port,
          rooms[3].current_preset.getValue());
      SendPlayOSC(rooms[3].servers[1].ip, rooms[3].servers[1].preset_port,
          rooms[3].current_preset.getValue());
      break;
    case 5:
      SendPresetOSC(rooms[4].servers[1].ip, rooms[4].servers[1].preset_port, 0);
      break;
    case 6:
      SendUDPMessage(rooms[5].servers[0],
          'Preset' + (rooms[5].current_preset.getValue() + 1).toString());
      SendUDPMessage(rooms[5].servers[1],
          'Preset' + (rooms[5].current_preset.getValue() + 1).toString());
  }
}

void StopPreset(int index) {
  switch (index) {
    case 2:
      for (Server server in rooms[1].servers) {
        SendUDPMessage(server, 'Preset0');
      }
      break;
    case 3:
      if (rooms[2].resolume) {
        SendStopOSC(rooms[2].servers[0].ip, rooms[2].servers[0].preset_port,
            rooms[2].current_preset.getValue());
      } else {
        SendUDPMessage(rooms[2].servers[0], 'Preset0');
      }
      break;
    case 4:
      SendStopOSC(rooms[3].servers[0].ip, rooms[3].servers[0].preset_port,
          rooms[3].current_preset.getValue());
      SendStopOSC(rooms[3].servers[1].ip, rooms[3].servers[1].preset_port,
          rooms[3].current_preset.getValue());
      break;
    case 5:
      SendPresetOSC(rooms[4].servers[1].ip, rooms[4].servers[1].preset_port, 1);
      break;
    case 6:
      SendUDPMessage(rooms[5].servers[0], 'Preset0');
      SendUDPMessage(rooms[5].servers[1], 'Preset0');
  }
}

void PlayAllPreset() {
  for (Server server in rooms[1].servers) {
    SendUDPMessage(
        server, 'Preset' + (rooms[1].current_preset.getValue() + 1).toString());
  }
  if (rooms[2].resolume) {
    SendPlayOSC(rooms[2].servers[0].ip, rooms[2].servers[0].preset_port,
        rooms[2].current_preset.getValue());
  } else {
    SendUDPMessage(rooms[2].servers[0], 'Preset1');
  }
  SendPlayOSC(rooms[3].servers[0].ip, rooms[3].servers[0].preset_port,
      rooms[3].current_preset.getValue());
  SendPlayOSC(rooms[3].servers[1].ip, rooms[3].servers[1].preset_port,
      rooms[3].current_preset.getValue());
  SendPresetOSC(rooms[4].servers[1].ip, rooms[4].servers[1].preset_port, 0);
  SendUDPMessage(rooms[5].servers[0],
      'Preset' + (rooms[5].current_preset.getValue() + 1).toString());
  SendUDPMessage(rooms[5].servers[1],
      'Preset' + (rooms[5].current_preset.getValue() + 1).toString());
}

void StopAllPreset() {
  for (Server server in rooms[1].servers) {
    SendUDPMessage(server, 'Preset0');
  }
  if (rooms[2].resolume) {
    SendStopOSC(rooms[2].servers[0].ip, rooms[2].servers[0].preset_port,
        rooms[2].current_preset.getValue());
  } else {
    SendUDPMessage(rooms[2].servers[0], 'Preset0');
  }
  SendStopOSC(rooms[3].servers[0].ip, rooms[3].servers[0].preset_port,
      rooms[3].current_preset.getValue());
  SendStopOSC(rooms[3].servers[1].ip, rooms[3].servers[1].preset_port,
      rooms[3].current_preset.getValue());
  SendPresetOSC(rooms[4].servers[1].ip, rooms[4].servers[1].preset_port, 1);
  SendUDPMessage(rooms[5].servers[0], 'Preset0');
  SendUDPMessage(rooms[5].servers[1], 'Preset0');
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
          SendUDPMessage(server,
              'Preset' + (room.current_preset.getValue() + 1).toString());
        }
      }
    } else {
      room.current_preset.setValue(room.presets.length - 1);
      for (Server server in room.servers) {
        if (room.resolume) {
          SendPresetOSC(
              server.ip, server.preset_port, room.current_preset.getValue());
        } else {
          SendUDPMessage(server,
              'Preset' + (room.current_preset.getValue() + 1).toString());
        }
      }
    }
  }
  PlayAllPreset();
}

void SwitchPreset(index) {
  for (Room room in rooms) {
    if (index < room.presets.length) {
      room.current_preset.setValue(index);
      for (Server server in room.servers) {
        if (room.resolume) {
          SendPresetOSC(
              server.ip, server.preset_port, room.current_preset.getValue());
        } else {
          SendUDPMessage(server,
              'Preset' + (room.current_preset.getValue() + 1).toString());
        }
      }
      // PlayAllPreset();
    } else {
      room.current_preset.setValue(room.presets.length - 1);
      for (Server server in room.servers) {
        if (room.resolume) {
          SendPresetOSC(
              server.ip, server.preset_port, room.current_preset.getValue());
        } else {
          SendUDPMessage(server,
              'Preset' + (room.current_preset.getValue() + 1).toString());
        }
      }
      // PlayAllPreset();
    }
  }
}

void OSCReceive() async {
  try {
    // final socket = await OSCSocket( serverAddress: InternetAddress(server.ip), serverPort: 7001);
    final socket =
        // await RawDatagramSocket.bind(InternetAddress.anyIPv4, 7001);
        await RawDatagramSocket.bind(InternetAddress('192.168.1.241'), 7001);
    // Đặt cổng lắng nghe OSC (ví dụ: 7001)
    OSCMessage oscMessage;
    socket.listen((event) async {
      if (event == RawSocketEvent.read) {
        final datagram = socket.receive();
        if (datagram != null) {
          oscMessage = OSCMessage.fromBytes(datagram.data);

          double transport =
              double.tryParse(oscMessage.arguments[0].toString()) ?? 0.0;
          String address = oscMessage.address;
          // if (allRoom.presets[allRoom.current_preset.getValue()].transport
          //         .getValue() <=
          //     1) {
          if (allRoom.presets.length > allRoom.current_preset.getValue()) {
            // //print('transport: $address $transport');
            if (transport > 0.999 && !allRoom.is_switch_colume.getValue()) {
              allRoom.is_switch_colume.setValue(true);
              //print('transport: $transport');
              if (allRoom.current_colume.getValue() != 3) {
                SwitchPreset(allRoom.current_colume.getValue());
              } else {
                SwitchPreset(0);
              }
              PlayAllPreset();
              await Future.delayed(Duration(seconds: 3));
              //print('switch done');
              allRoom.is_switch_colume.setValue(false);
            }
            ////print(allRoom.current_preset.getValue());
            if (allRoom.current_preset.getValue() == 0) {
              if (address ==
                  '/composition/layers/1/clips/1/transport/position') {
                //print('transport: ${transport * 0.5}');
                allRoom.current_colume.setValue(1);
                allRoom.presets[allRoom.current_preset.getValue()].transport
                    .setValue(transport * 0.5);
              } else if (address ==
                  '/composition/layers/1/clips/2/transport/position') {
                //print('transport: ${transport * 0.27 + 0.5}');
                allRoom.current_colume.setValue(2);
                allRoom.presets[allRoom.current_preset.getValue()].transport
                    .setValue(transport * 0.27 + 0.5);
              } else if (address ==
                  '/composition/layers/1/clips/3/transport/position') {
                //print('transport: ${transport * 0.23 + 0.77}');
                allRoom.current_colume.setValue(3);
                allRoom.presets[allRoom.current_preset.getValue()].transport
                    .setValue(transport * 0.23 + 0.77);
              }
            } else if (allRoom.current_preset.getValue() == 1) {
              if (address ==
                  '/composition/layers/1/clips/1/transport/position') {
                //print('transport: ${transport * 0.5 + 0.5}');
                allRoom.current_colume.setValue(1);
                allRoom.presets[allRoom.current_preset.getValue()].transport
                    .setValue(transport * 0.5 + 0.5);
              } else if (address ==
                  '/composition/layers/1/clips/2/transport/position') {
                //print('transport: ${transport * 0.27}');
                allRoom.current_colume.setValue(2);
                allRoom.presets[allRoom.current_preset.getValue()].transport
                    .setValue(transport * 0.27);
              } else if (address ==
                  '/composition/layers/1/clips/3/transport/position') {
                //print('transport: ${transport * 0.23 + 0.27}');
                allRoom.current_colume.setValue(3);
                allRoom.presets[allRoom.current_preset.getValue()].transport
                    .setValue(transport * 0.23 + 0.27);
              }
            } else if (allRoom.current_preset.getValue() == 2) {
              if (address ==
                  '/composition/layers/1/clips/1/transport/position') {
                //print('transport: ${transport * 0.5 + 0.23}');
                allRoom.current_colume.setValue(1);
                allRoom.presets[allRoom.current_preset.getValue()].transport
                    .setValue(transport * 0.5 + 0.23);
              } else if (address ==
                  '/composition/layers/1/clips/2/transport/position') {
                //print('transport: ${transport * 0.27 + 0.73}');
                allRoom.current_colume.setValue(2);
                allRoom.presets[allRoom.current_preset.getValue()].transport
                    .setValue(transport * 0.27 + 0.73);
              } else if (address ==
                  '/composition/layers/1/clips/3/transport/position') {
                //print('transport: ${transport * 0.23}');
                allRoom.current_colume.setValue(3);
                allRoom.presets[allRoom.current_preset.getValue()].transport
                    .setValue(transport * 0.23);
              }
            }
          }
          if (rooms[(current_page.getValue() > 1)
                      ? current_page.getValue() - 1
                      : 1]
                  .presets
                  .length >
              rooms[(current_page.getValue() > 1)
                      ? current_page.getValue() - 1
                      : 1]
                  .current_preset
                  .getValue()) {
            rooms[(current_page.getValue() > 1)
                    ? current_page.getValue() - 1
                    : 1]
                .presets[rooms[(current_page.getValue() > 1)
                        ? current_page.getValue() - 1
                        : 1]
                    .current_preset
                    .getValue()]
                .transport
                .setValue(transport);
          }
          // }
          // ////print('Argument value: ' +
          //     rooms[(current_page.getValue() > 1) ? current_page.getValue() - 1 : 1]
          //         .presets[
          //             rooms[(current_page.getValue() > 1) ? current_page.getValue() - 1 : 1].current_preset.getValue()]
          //         .transport
          //         .getValue()
          //         .toString());
        }
      }
    });
  } catch (e) {
    ////print(e);
  }
}
