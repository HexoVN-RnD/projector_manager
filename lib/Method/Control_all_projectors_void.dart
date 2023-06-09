import 'package:responsive_dashboard/Method/ping_check_connection.dart';
import 'package:responsive_dashboard/Method/projector_command.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:valuable/valuable.dart';

// void select_preset(int index) async {
//   allRoom.current_preset.setValue(index);
//   for (Room room in rooms) {
//     room.current_preset.setValue(index);
//   }
// }

void PowerAllProjectors(bool mode) {
  allRoom.power_all_projectors.setValue(mode);
  for (var room in rooms) {
    for (var projector in room.projectors) {
      if (projector.power_status_button.getValue() !=
          allRoom.power_all_projectors.getValue()) {
        if (allRoom.power_all_projectors.getValue()) {
          if(projector.type == 'Christie') {
            print(projector.ip.toString() + '(PWR 1)');
            checkConnectionProjector(projector);
            sendTCPIPCommand(projector, '(PWR 1)');
          } else {
            print(projector.ip.toString() + '(%1POWR 1)');
            checkConnectionProjector(projector);
            sendPJLinkCommand(projector, '(%1POWR 1)');
          }
        } else {
          if(projector.type == 'Christie') {
            print(projector.ip.toString() + '(PWR 0)');
            checkConnectionProjector(projector);
            sendTCPIPCommand(projector, '(PWR 0)');
          } else {
            print(projector.ip.toString() + '(%1POWR 0)');
            checkConnectionProjector(projector);
            sendPJLinkCommand(projector, '(%1POWR 0)');
          }
        }
      }
      projector.power_status_button
          .setValue(allRoom.power_all_projectors.getValue());
    }
  }
}

void ShutterAllProjectors(bool mode) {
  allRoom.shutter_all_projectors.setValue(mode);
  for (var room in rooms) {
    for (var projector in room.projectors) {
      if (projector.shutter_status_button.getValue() !=
          allRoom.shutter_all_projectors.getValue()) {
        if (allRoom.shutter_all_projectors.getValue()) {
          if(projector.type == 'Christie') {
            print(projector.ip.toString() + '(SHU 1)');
            checkConnectionProjector(projector);
            sendTCPIPCommand(projector, '(SHU 1)');
          } else {
            print(projector.ip.toString() + '(%SHUT 1)');
            checkConnectionProjector(projector);
            sendPJLinkCommand(projector, '(%SHUT 1)');
          }
        } else {
          if(projector.type == 'Christie') {
            print(projector.ip.toString() + '(SHU 0)');
            checkConnectionProjector(projector);
            sendTCPIPCommand(projector, '(SHU 0)');
          } else {
            print(projector.ip.toString() + '(%SHUT 0)');
            checkConnectionProjector(projector);
            sendPJLinkCommand(projector, '(%SHUT 0)');
          }
        }
      }
      projector.shutter_status_button
          .setValue(allRoom.shutter_all_projectors.getValue());
    }
  }
}

void TestPatternSelectAll(int num ) {
  allRoom.current_test_pattern.setValue(num);
  for (var room in rooms) {
    for (var projector in room.projectors) {
        print(projector.ip.toString() + '(ITP $num)');
        checkConnectionProjector(projector);
        sendTCPIPCommand(projector, '(ITP $num)');
    }
  }
}

void LampMode(int num) {
  allRoom.lamp_mode.setValue(num);
  if (num == 0) {
    allRoom.A1.setValue(true);
    allRoom.A2.setValue(true);
    allRoom.A3.setValue(true);
    allRoom.B1.setValue(true);
    allRoom.B2.setValue(true);
    allRoom.B3.setValue(true);
  } else if (num == 1){
    allRoom.A1.setValue(true);
    allRoom.A2.setValue(true);
    allRoom.A3.setValue(true);
    allRoom.B1.setValue(false);
    allRoom.B2.setValue(false);
    allRoom.B3.setValue(false);
  } else if (num == 2){
    allRoom.A1.setValue(false);
    allRoom.A2.setValue(false);
    allRoom.A3.setValue(false);
    allRoom.B1.setValue(true);
    allRoom.B2.setValue(true);
    allRoom.B3.setValue(true);

  } else if (num == 3){
    allRoom.A1.setValue(true);
    allRoom.A2.setValue(false);
    allRoom.A3.setValue(false);
    allRoom.B1.setValue(true);
    allRoom.B2.setValue(false);
    allRoom.B3.setValue(false);

  } else if (num == 4){
    allRoom.A1.setValue(false);
    allRoom.A2.setValue(true);
    allRoom.A3.setValue(false);
    allRoom.B1.setValue(false);
    allRoom.B2.setValue(true);
    allRoom.B3.setValue(false);

  } else if (num == 5){
    allRoom.A1.setValue(false);
    allRoom.A2.setValue(false);
    allRoom.A3.setValue(true);
    allRoom.B1.setValue(false);
    allRoom.B2.setValue(false);
    allRoom.B3.setValue(true);

  }
  // for (var room in rooms) {
  //   for (var projector in room.projectors) {
  //     print(projector.ip.toString() + '(LMP $num)');
  //     checkConnectionProjector(projector);
  //     sendTCPIPCommand(projector, '(LMP $num)');
  //   }
  // }
}

void ElectronicMode(bool mode) {
  allRoom.electronic_mode.setValue(mode);
  for (var room in rooms) {
    for (var projector in room.projectors) {
      if (allRoom.electronic_mode.getValue()) {
        print(projector.ip.toString() + '(ELT 1)');
        checkConnectionProjector(projector);
        sendTCPIPCommand(projector, '(ELT 1)');
      } else {
        print(projector.ip.toString() + '(SHU 0)');
        checkConnectionProjector(projector);
        sendTCPIPCommand(projector, '(ELT 0)');
      }
    }
  }
}
void ADSMode(bool mode) {
  allRoom.ASD_mode.setValue(mode);
  for (var room in rooms) {
    for (var projector in room.projectors) {
      if (allRoom.ASD_mode.getValue()) {
        print(projector.ip.toString() + '(ASD 1)');
        checkConnectionProjector(projector);
        sendTCPIPCommand(projector, '(ASD 1)');
      } else {
        print(projector.ip.toString() + '(ASD 0)');
        checkConnectionProjector(projector);
        sendTCPIPCommand(projector, '(ASD 0)');
      }
    }
  }
}
void OSDMode(bool mode) {
  allRoom.OSD_mode.setValue(mode);
  for (var room in rooms) {
    for (var projector in room.projectors) {
      if (allRoom.OSD_mode.getValue()) {
        print(projector.ip.toString() + '(OSD 1)');
        checkConnectionProjector(projector);
        sendTCPIPCommand(projector, '(OSD 1)');
      } else {
        print(projector.ip.toString() + '(OSD 0)');
        checkConnectionProjector(projector);
        sendTCPIPCommand(projector, '(OSD 0)');
      }
    }
  }
}
void WhiteOrGreenMode(bool mode) {
  allRoom.whiteOrGreen.setValue(mode);
  for (var room in rooms) {
    for (var projector in room.projectors) {
      if (allRoom.whiteOrGreen.getValue()) {
        print(projector.ip.toString() + '(WOG 1)');
        checkConnectionProjector(projector);
        sendTCPIPCommand(projector, '(WOG 1)');
      } else {
        print(projector.ip.toString() + '(WOG 0)');
        checkConnectionProjector(projector);
        sendTCPIPCommand(projector, '(WOG 0)');
      }
    }
  }
}

// void PowerAllServers(bool mode) {
//   print(mode);
//   allRoom.power_all_servers.setValue(mode);
//   for (var room in rooms) {
//     for (var server in room.servers) {
//       server.power_status.setValue(allRoom.power_all_servers.getValue());
//     }
//   }
// }

// void ChangeAllVolume(double index) {
//   allRoom.volume_all.setValue(index);
//   for (var room in rooms) {
//     for (var server in room.servers) {
//       server.volume.setValue(index);
//     }
//   }
// }
