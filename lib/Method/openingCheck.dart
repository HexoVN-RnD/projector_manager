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
  // allRoom.setAllVolume();
  allRoom.setLicenseStatus();
  for (Room room in rooms) {
    // room.setRoomVolume();
    allRoom.num_servers
         = (allRoom.num_servers + room.servers.length);
    allRoom.num_sensors
         = (allRoom.num_sensors + room.sensors.length);
    allRoom.num_leds
         = (allRoom.num_leds + room.leds.length);
    allRoom.num_projectors
         = (allRoom.num_projectors + room.projectors.length);
  }
}