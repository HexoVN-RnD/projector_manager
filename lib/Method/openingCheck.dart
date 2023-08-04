import 'package:responsive_dashboard/Method/Control_projector_void.dart';
import 'package:responsive_dashboard/Method/ping_check_connection.dart';
import 'package:responsive_dashboard/Method/projector_command.dart';
import 'package:responsive_dashboard/Method/projector_void.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/Sensor.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/openingScene.dart';

Future<void> OpeningCheck() async {
  for (Room room in rooms) {
    allRoom.num_servers
        .setValue(allRoom.num_servers.getValue() + room.servers.length);
    allRoom.num_sensors
        .setValue(allRoom.num_sensors.getValue() + room.sensors.length);
    allRoom.num_projectors
        .setValue(allRoom.num_projectors.getValue() + room.projectors.length);
  }
  for (Room room in rooms) {
    if (!room.servers.isEmpty)
      for (Server server in room.servers) {
        checkConnectionServerResponse(server);
      }
    if (!room.sensors.isEmpty) {
      for (Sensor sensor in room.sensors) {
        checkConnectionSensor(sensor);
      }
    }
    if (room.projectors.length > 0) {
      RoomPowerStatus(room);
    }
  }
  await Future.delayed(Duration(seconds: 2));
  for (Room room in rooms) {
    RoomShutterStatus(room);
  }
}