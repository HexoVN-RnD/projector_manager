import 'package:responsive_dashboard/Method/projector_command.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/data/data.dart';

void OpeningCheck()  {
  // allRoom.num_projectors.setValue(value)
  for (Room room in rooms) {
    allRoom.num_servers.setValue(allRoom.num_servers.getValue()+room.servers.length);
    allRoom.num_projectors.setValue(allRoom.num_projectors.getValue()+room.projectors.length);
  }

}


