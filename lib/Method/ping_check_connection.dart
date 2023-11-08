import 'dart:io';
import 'package:valuable/valuable.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:responsive_dashboard/Method/Control_all_projectors_void.dart';
import 'package:responsive_dashboard/Method/projector_command.dart';
import 'package:responsive_dashboard/Object/Led.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/Sensor.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/data/data.dart';

void checkConnectionServer(Room room, Server server) {
  int count = 0;
  final ping = Ping(server.ip, count: 1); // Thay đổi số lần ping tùy ý

  ping.stream.listen((event) {
    // //print('ping server ${server.ip} response ${event.response?.time} ${count}');
    // //print('Ping to ${server.ip}: ${event.response?.time} ms');
    if (event.response?.time != null) {
      if(room.resolume && event.response?.ttl==128) {
        server.connected = (true);
      } else if (!room.resolume && event.response?.ttl==64) {
        server.connected = (true);
      } else {
        server.connected = (false);
      }
      // server.power_status = (true);
    } else if (event.response?.time == null && count != 1) {
      server.connected = (false);
      // server.power_status = (false);
      // //print('ping server ${event.response?.ip} ${count}');
    }
    count++;
  });
  ping.command;
}

void checkConnectionServerResponse(Room room, Server server) {
  int count = 0;
  final ping = Ping(server.ip, count: 1); // Thay đổi số lần ping tùy ý

  ping.stream.listen((event) {
    // //print('ping server ${server.ip} response ${event.response?.time} ${count}');
    // //print('Ping to ${server.ip}: ${event.response?.time} ms');
    if (event.response?.time != null) {
      if(room.resolume && event.response?.ttl==128) {
        server.connected = (true);
        server.power_status = (true);
        //print('Connected to ${server.ip}: ${event.response?.time} ms');
      } else if (!room.resolume && event.response?.ttl==64) {
        server.connected = (true);
        server.power_status = (true);
        //print('Connected to ${server.ip}: ${event.response?.time} ms');
      } else {
        server.connected = (false);
        server.power_status = (false);
        //print('Disconnected to ${server.ip}: ${event.response?.time} ms');
      }

    } else if (event.response?.time == null && count != 1) {
      server.connected = (false);
      server.power_status = (false);
      // //print('ping server ${event.response?.ip} ${count}');
    }
    count++;
  });
  ping.command;
}

void checkConnectionSensor(Sensor sensor) {
  int count = 0;
  final ping = Ping(sensor.ip, count: 1); // Thay đổi số lần ping tùy ý
  ping.stream.listen((event) {
    // //print('ping sensor ${sensor.ip}: response ${event.response?.time} ${count}');
    // //print('Ping to ${sensor.ip}: ${event.response?.time} ms');
    if (event.response?.time != null) {
      sensor.connected = (true);
      //print('Connected to ${sensor.ip}: ${event.response?.time} ms');
    } else if (event.response?.ip == null && count != 1) {
      sensor.connected = (false);
      // //print('Error');
    }
    count++;
    // ping.stop();
  }, onError: (error) {
    //print(error);
  });
  ping.command;
}

void checkConnectionLed(Led led) {
  int count = 0;
  final ping = Ping(led.ip, count: 1); // Thay đổi số lần ping tùy ý
  ping.stream.listen((event) {
    // //print('ping led ${led.ip}: response ${event.response?.time} ${count}');
    // //print('Ping to ${led.ip}: ${event.response?.time} ms');
    if (event.response?.time != null) {
      led.connected = (true);
      //print('Connected to ${led.ip}: ${event.response?.time} ms');
    } else if (event.response?.ip == null && count != 1) {
      led.connected = (false);
      // //print('Error');
    }
    count++;
    // ping.stop();
  }, onError: (error) {
    //print(error);
  });
  ping.command;
}

void checkConnectionProjector(Projector projector) {
  int count = 0;
  final ping = Ping(projector.ip, count: 1); // Thay đổi số lần ping tùy ý

  ping.stream.listen((event) {
    // //print('Ping to ${projector.ip}: ${event.response?.time} ms');
    if (event.response?.time != null) {
      projector.connected = (true);
      ping.stop();
    } else if (event.response?.ip == null && count != 1) {
      projector.connected = (false);
      // //print('Error');
    }
    count++;
  });
  ping.command;
}

Future<void> checkAllRoomConnection(int time) async {
  //print('checkAllRoomConnection');
  int length =
      allRoom.num_servers + allRoom.num_projectors;
  for (Room room in rooms) {
    if (!room.sensors.isEmpty) {
      for (Sensor sensor in room.sensors) {
        checkConnectionSensor(sensor);
      }
    }
    if (!room.leds.isEmpty) {
      for (Led led in room.leds) {
        checkConnectionLed(led);
      }
    }
    if (!room.projectors.isEmpty) {
      for (Projector projector in room.projectors) {
        await Future.delayed(Duration(milliseconds: time ~/ length));
        checkConnectionProjector(projector);
        if (projector.type == 'Christie') {
          String response = sendTCPIPCommandStatus(projector);
          //print(response);
        } else {
          sendPJLinkCommandStatus(projector);
        }
      }
    }
    if (!room.servers.isEmpty) {
      for (Server server in room.servers) {
        await Future.delayed(Duration(milliseconds: time ~/ length));
        checkConnectionServerResponse(room,server);
      }
    }
  }
  SetButtonControlAllSystem();
}

Future<void> checkFullConnection(int time) async {
  //print('checkAllRoomConnection');
  int length =
      allRoom.num_servers + allRoom.num_projectors;
  for (Room room in rooms) {
    if (!room.sensors.isEmpty) {
      for (Sensor sensor in room.sensors) {
        checkConnectionSensor(sensor);
      }
    }
    if (!room.leds.isEmpty) {
      for (Led led in room.leds) {
        checkConnectionLed(led);
      }
    }
    if (!room.projectors.isEmpty) {
      for (Projector projector in room.projectors) {
        await Future.delayed(Duration(milliseconds: time ~/ length));
        checkConnectionProjector(projector);
        if (projector.type == 'Christie') {
          String response = sendTCPIPCommandStatus(projector);
          //print(response);
        } else {
          String response = sendPJLinkCommandStatus(projector);
          //print(response);
        }
      }
    }
    if (!room.servers.isEmpty) {
      for (Server server in room.servers) {
        await Future.delayed(Duration(milliseconds: time ~/ length));
        checkConnectionServerResponse(room,server);
      }
    }
  }
  SetButtonControlAllSystem();
}

Future<void> checkRoomProjectorConnection(Room room, int time) async {
  //print('checkRoomProjectorConnection');
  if (!room.projectors.isEmpty) {
    for (Projector projector in room.projectors) {
      await Future.delayed(
          Duration(milliseconds: time ~/ room.projectors.length));
      checkConnectionProjector(projector);
      if (projector.type == 'Christie') {
        String response = sendTCPIPCommandStatus(projector);
        //print(response);
      } else {
        String response = sendPJLinkCommandStatus(projector);
        //print(response);
      }
    }
  }
}

Future<void> checkRoomServerConnection(Room room, int time) async {
  //print('checkRoomServerConnection');
  if (!room.servers.isEmpty) {
    for (Server server in room.servers) {
      await Future.delayed(
          Duration(milliseconds: time ~/ room.servers.length));
      checkConnectionServerResponse(room,server);
    }
  }
}

Future<void> checkRoomSensorConnection(Room room) async {
  //print('checkRoomSensorConnection');
  if (!room.sensors.isEmpty) {
    for (Sensor sensor in room.sensors) {
      checkConnectionSensor(sensor);
    }
  }
}
Future<void> checkRoomLedConnection(Room room) async {
  //print('checkRoomLedConnection');
  if (!room.leds.isEmpty) {
    for (Led led in room.leds) {
      checkConnectionLed(led);
    }
  }
}
