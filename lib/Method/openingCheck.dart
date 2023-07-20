import 'package:responsive_dashboard/Method/excel.dart';
import 'package:responsive_dashboard/Method/ping_check_connection.dart';
import 'package:responsive_dashboard/Method/projector_command.dart';
import 'package:responsive_dashboard/Method/projector_void.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/Sensor.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/openingScene.dart';

void OpeningCheck() async {
  allRoom.volume_all.setValue(await readCellValue(1,1));
  for (Room room in rooms) {
    allRoom.num_servers
        .setValue(allRoom.num_servers.getValue() + room.servers.length);
    allRoom.num_sensors
        .setValue(allRoom.num_sensors.getValue() + room.sensors.length);
    allRoom.num_projectors
        .setValue(allRoom.num_projectors.getValue() + room.projectors.length);

    for (Server server in room.servers) {
      checkConnectionServer(server.ip, server.connected, server.power_status);
      server.volume.setValue(await readCellValue(server.id,1));
      Future.delayed(Duration(seconds: 1), () {
        if (server.connected.getValue()) {
          allRoom.num_servers_connected
              .setValue(allRoom.num_servers_connected.getValue() + 1);
        }
      });
    }
    for (Sensor sensor in room.sensors) {
      checkConnectionSensor(sensor.ip, sensor.connected);
    }
    for (Projector projector in room.projectors) {
      checkConnectionProjector(projector);
      Future.delayed(Duration(seconds: 1), () {
        if (projector.connected.getValue()) {
          allRoom.num_projectors_connected
              .setValue(allRoom.num_projectors_connected.getValue() + 1);
          PowerStatus(projector);
          ShutterStatus(projector);
        }
      });
    }
  }
}
