import 'dart:io';

import 'package:dart_ping/dart_ping.dart';
import 'package:responsive_dashboard/Method/Control_all_projectors_void.dart';
import 'package:responsive_dashboard/Method/Control_projector_void.dart';
import 'package:responsive_dashboard/Method/networkAddress.dart';
import 'package:responsive_dashboard/Method/projector_command.dart';
import 'package:responsive_dashboard/Method/projector_void.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/Sensor.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:valuable/valuable.dart';

void checkConnectionServer(Server server) {
  int count = 0;
  final ping = Ping(server.ip, count: 1); // Thay đổi số lần ping tùy ý

  ping.stream.listen((event) {
    // print('ping server ${server.ip} response ${event.response?.time} ${count}');
    // print('Ping to ${server.ip}: ${event.response?.time} ms');
    if (event.response?.time != null) {
      server.connected.setValue(true);
      // server.power_status.setValue(true);
    } else if (event.response?.time == null && count != 1) {
      server.connected.setValue(false);
      // server.power_status.setValue(false);
      // print('ping server ${event.response?.ip} ${count}');
    }
    count++;
  });
  ping.command;
}

void checkConnectionServerResponse(Server server) {
  int count = 0;
  final ping = Ping(server.ip, count: 1); // Thay đổi số lần ping tùy ý

  ping.stream.listen((event) {
    // print('ping server ${server.ip} response ${event.response?.time} ${count}');
    // print('Ping to ${server.ip}: ${event.response?.time} ms');
    if (event.response?.time != null) {
      server.connected.setValue(true);
      server.power_status.setValue(true);
      print('Connected to ${server.ip}: ${event.response?.time} ms');
    } else if (event.response?.time == null && count != 1) {
      server.connected.setValue(false);
      server.power_status.setValue(false);
      // print('ping server ${event.response?.ip} ${count}');
    }
    count++;
  });
  ping.command;
}

void checkConnectionSensor(Sensor sensor) {
  int count = 0;
  final ping = Ping(sensor.ip, count: 1); // Thay đổi số lần ping tùy ý
  ping.stream.listen((event) {
    // print('ping sensor ${sensor.ip}: response ${event.response?.time} ${count}');
    // print('Ping to ${sensor.ip}: ${event.response?.time} ms');
    if (event.response?.time != null) {
      sensor.connected.setValue(true);
      print('Connected to ${sensor.ip}: ${event.response?.time} ms');
    } else if (event.response?.ip == null && count != 1) {
      sensor.connected.setValue(false);
      // print('Error');
    }
    count++;
    // ping.stop();
  }, onError: (error) {
    print(error);
  });
  ping.command;
}

void checkConnectionProjector(Projector projector) {
  int count = 0;
  final ping = Ping(projector.ip, count: 1); // Thay đổi số lần ping tùy ý

  ping.stream.listen((event) {
    // print('Ping to ${projector.ip}: ${event.response?.time} ms');
    if (event.response?.time != null) {
      projector.connected.setValue(true);
      ping.stop();
    } else if (event.response?.ip == null && count != 1) {
      projector.connected.setValue(false);
      // print('Error');
    }
    count++;
  });
  ping.command;
}

Future<void> checkAllRoomConnection(int time) async {
  print('checkAllRoomConnection');
  int length =
      allRoom.num_servers.getValue() + allRoom.num_projectors.getValue();
  for (Room room in rooms) {
    if (!room.sensors.isEmpty) {
      for (Sensor sensor in room.sensors) {
        checkConnectionSensor(sensor);
      }
    }
    if (!room.projectors.isEmpty) {
      for (Projector projector in room.projectors) {
        await Future.delayed(Duration(milliseconds: (time / length).toInt()));
        checkConnectionProjector(projector);
        if (projector.type == 'Christie') {
          String response = sendTCPIPCommandStatus(projector);
          print(response);
        } else {
          sendPJLinkCommandStatus(projector);
        }
      }
    }
    if (!room.servers.isEmpty) {
      for (Server server in room.servers) {
        await Future.delayed(Duration(milliseconds: (time / length).toInt()));
        checkConnectionServerResponse(server);
      }
    }
  }
  SetButtonControlAllSystem();
}

Future<void> checkFullConnection(int time) async {
  print('checkAllRoomConnection');
  int length =
      allRoom.num_servers.getValue() + allRoom.num_projectors.getValue();
  for (Room room in rooms) {
    if (!room.sensors.isEmpty) {
      for (Sensor sensor in room.sensors) {
        checkConnectionSensor(sensor);
      }
    }
    if (!room.projectors.isEmpty) {
      for (Projector projector in room.projectors) {
        await Future.delayed(Duration(milliseconds: (time / length).toInt()));
        checkConnectionProjector(projector);
        if (projector.type == 'Christie') {
          String response = sendTCPIPCommandStatus(projector);
          print(response);
        } else {
          String response = sendPJLinkCommandStatus(projector);
          print(response);
        }
      }
    }
    if (!room.servers.isEmpty) {
      for (Server server in room.servers) {
        await Future.delayed(Duration(milliseconds: (time / length).toInt()));
        checkConnectionServerResponse(server);
      }
    }
  }
  SetButtonControlAllSystem();
}

Future<void> checkRoomProjectorConnection(Room room, int time) async {
  print('checkRoomProjectorConnection');
  if (!room.projectors.isEmpty) {
    for (Projector projector in room.projectors) {
      await Future.delayed(
          Duration(milliseconds: (time / room.projectors.length).toInt()));
      checkConnectionProjector(projector);
      if (projector.type == 'Christie') {
        String response = sendTCPIPCommandStatus(projector);
        print(response);
      } else {
        String response = sendPJLinkCommandStatus(projector);
        print(response);
      }
    }
  }
}

Future<void> checkRoomServerConnection(Room room, int time) async {
  print('checkRoomServerConnection');
  if (!room.servers.isEmpty) {
    for (Server server in room.servers) {
      await Future.delayed(
          Duration(milliseconds: (time / room.servers.length).toInt()));
      checkConnectionServerResponse(server);
    }
  }
}

Future<void> checkRoomSensorConnection(Room room) async {
  print('checkRoomSensorConnection');
  if (!room.sensors.isEmpty) {
    for (Sensor sensor in room.sensors) {
      checkConnectionSensor(sensor);
    }
  }
}
