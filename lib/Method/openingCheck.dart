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
  // allRoom.num_projectors.setValue(value)
  for (Room room in rooms) {
    allRoom.num_servers
        .setValue(allRoom.num_servers.getValue() + room.servers.length);
    allRoom.num_sensors
        .setValue(allRoom.num_sensors.getValue() + room.sensors.length);
    allRoom.num_projectors
        .setValue(allRoom.num_projectors.getValue() + room.projectors.length);
  }
  // final num_devices = allRoom.num_servers.getValue()+allRoom.num_sensors.getValue()+allRoom.num_projectors.getValue();
  // int count = 0;
  for (Room room in rooms) {
    for (Server server in room.servers) {
      checkConnectionServer(server.ip, server.connected, server.power_status);
      // count += 1;
      // print('$count per $num_devices');
      // // set percent progress bar
      // opening_per.setValue(opening_per.getValue()+1/num_devices*0.99);
      if (server.connected.getValue()) {
        allRoom.num_servers_connected
            .setValue(allRoom.num_servers_connected.getValue() + 1);
      }
    }
    for (Sensor sensor in room.sensors) {
      checkConnectionSensor(sensor.ip, sensor.connected);
      // count += 1;
      // print('$count per $num_devices');
      // // set percent progress bar
      // opening_per.setValue(opening_per.getValue()+1/num_devices*0.99);
    }
    for (Projector projector in room.projectors) {
      PowerStatus(projector);
      print('pro');
    }
    await Future.delayed(Duration(seconds: 10));
    for (Projector projector in room.projectors) {
      sendTCPIPCommand(projector, '(SHU?)');
      print('shu');
    }
    // for (Projector projector in room.projectors) {
    //   checkConnectionProjector(projector);
    //   // count += 1;
    //   // print('$count per $num_devices');
    //   // // set percent progress bar
    //   // opening_per.setValue(opening_per.getValue()+1/num_devices*0.99);
    //   if (projector.connected.getValue()) {
    //     allRoom.num_projectors_connected
    //         .setValue(allRoom.num_projectors_connected.getValue() + 1);
    //     PowerStatus(projector);
    //     ShutterStatus(projector);
    //   }
    // }
  }
}



