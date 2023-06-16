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
          if (projector.type == 'Christie') {
            print(projector.ip.toString() + '(PWR 1)');
            // checkConnectionProjector(projector);
            sendTCPIPCommand(projector, '(PWR 1)');
            
          } else {
            print(projector.ip.toString() + '(%1POWR 1[CR])');
            // checkConnectionProjector(projector);
            sendPJLinkCommand(projector, '(%1POWR 1[CR])');
            
          }
        } else {
          if (projector.type == 'Christie') {
            print(projector.ip.toString() + '(PWR 0)');
            // checkConnectionProjector(projector);
            sendTCPIPCommand(projector, '(PWR 0)');
            
          } else {
            print(projector.ip.toString() + '(%1POWR 0[CR])');
            // checkConnectionProjector(projector);
            sendPJLinkCommand(projector, '(%1POWR 0[CR])');
            
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
          if (projector.type == 'Christie') {
            print(projector.ip.toString() + '(SHU 0)');
            // checkConnectionProjector(projector);
            sendTCPIPCommand(projector, '(SHU 0)');
            
          } else {
            print(projector.ip.toString() + '(%1AVMT 30[CR])');
            // checkConnectionProjector(projector);
            sendPJLinkCommand(projector, '(%1AVMT 30[CR])');
          }
        } else {
          if (projector.type == 'Christie') {
            print(projector.ip.toString() + '(SHU 1)');
            // checkConnectionProjector(projector);
            sendTCPIPCommand(projector, '(SHU 1)');
            
          } else {
            print(projector.ip.toString() + '(%1AVMT 31[CR])');
            // checkConnectionProjector(projector);
            sendPJLinkCommand(projector, '(%1AVMT 31[CR])');
            
          }
        }
      }
      projector.shutter_status_button
          .setValue(allRoom.shutter_all_projectors.getValue());
    }
  }
}

void TestPatternSelectAll(int num) {
  allRoom.current_test_pattern.setValue(num);
  for (var room in rooms) {
    for (var projector in room.projectors) {
      // checkConnectionProjector(projector);
      if (num == 0) {
        print(projector.ip.toString() + '(ITP 0)');
        sendTCPIPCommand(projector, '(ITP 0)');
        
      } else if (num == 1) {
        print(projector.ip.toString() + '(ITP 1)');
        sendTCPIPCommand(projector, '(ITP 1)');
        
      } else if (num == 2) {
        print(projector.ip.toString() + '(ITP 3)');
        sendTCPIPCommand(projector, '(ITP 3)');
        
      } else if (num == 3) {
        print(projector.ip.toString() + '(ITP 5)');
        sendTCPIPCommand(projector, '(ITP 5)');
        
      } else if (num == 4) {
        print(projector.ip.toString() + '(ITP 9)');
        sendTCPIPCommand(projector, '(ITP 9)');
        
      }
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
    for (var room in rooms) {
      for (var projector in room.projectors) {
        print(projector.ip.toString() + '(LOP+MULT 63)');
        // checkConnectionProjector(projector);
        sendTCPIPCommand(projector, '(LOP+MULT 63))');
      }
    }
  } else if (num == 1) {
    allRoom.A1.setValue(true);
    allRoom.A2.setValue(true);
    allRoom.A3.setValue(true);
    allRoom.B1.setValue(false);
    allRoom.B2.setValue(false);
    allRoom.B3.setValue(false);
    for (var room in rooms) {
      for (var projector in room.projectors) {
        print(projector.ip.toString() + '(LOP+MULT 7)');
        // checkConnectionProjector(projector);
        sendTCPIPCommand(projector, '(LOP+MULT 7)');
      }
    }
  } else if (num == 2) {
    allRoom.A1.setValue(false);
    allRoom.A2.setValue(false);
    allRoom.A3.setValue(false);
    allRoom.B1.setValue(true);
    allRoom.B2.setValue(true);
    allRoom.B3.setValue(true);
    for (var room in rooms) {
      for (var projector in room.projectors) {
        print(projector.ip.toString() + '(LOP+MULT 56)');
        // checkConnectionProjector(projector);
        sendTCPIPCommand(projector, '(LOP+MULT 56)');
      }
    }
  } else if (num == 3) {
    allRoom.A1.setValue(true);
    allRoom.A2.setValue(false);
    allRoom.A3.setValue(false);
    allRoom.B1.setValue(true);
    allRoom.B2.setValue(false);
    allRoom.B3.setValue(false);
    for (var room in rooms) {
      for (var projector in room.projectors) {
        print(projector.ip.toString() + '(LOP+MULT 9)');
        // checkConnectionProjector(projector);
        sendTCPIPCommand(projector, '(LOP+MULT 9)');
      }
    }
  } else if (num == 4) {
    allRoom.A1.setValue(false);
    allRoom.A2.setValue(true);
    allRoom.A3.setValue(false);
    allRoom.B1.setValue(false);
    allRoom.B2.setValue(true);
    allRoom.B3.setValue(false);
    for (var room in rooms) {
      for (var projector in room.projectors) {
        print(projector.ip.toString() + '(LOP+MULT 18)');
        // checkConnectionProjector(projector);
        sendTCPIPCommand(projector, '(LOP+MULT 18)');
      }
    }
  } else if (num == 5) {
    allRoom.A1.setValue(false);
    allRoom.A2.setValue(false);
    allRoom.A3.setValue(true);
    allRoom.B1.setValue(false);
    allRoom.B2.setValue(false);
    allRoom.B3.setValue(true);
    for (var room in rooms) {
      for (var projector in room.projectors) {
        print(projector.ip.toString() + '(LOP+MULT 36)');
        // checkConnectionProjector(projector);
        sendTCPIPCommand(projector, '(LOP+MULT 36)');
      }
    }
  }
  // for (var room in rooms) {
  //   for (var projector in room.projectors) {
  //     print(projector.ip.toString() + '(LMP $num)');
  //     // checkConnectionProjector(projector);
  //     sendTCPIPCommand(projector, '(LMP $num)');
  //   }
  // }
}

void ElectronicMode(bool mode) {
  allRoom.electronic_mode.setValue(mode);
  for (var room in rooms) {
    for (var projector in room.projectors) {
      if (allRoom.electronic_mode.getValue()) {
        print(projector.ip.toString() + '(PWR+ELEC 1)');
        // checkConnectionProjector(projector);
        sendTCPIPCommand(projector, '(PWR+ELEC 1)');
      } else {
        print(projector.ip.toString() + '(PWR+ELEC 0)');
        // checkConnectionProjector(projector);
        sendTCPIPCommand(projector, '(PWR+ELEC 0)');
      }
    }
  }
}

void ASUMode(bool mode) {
  allRoom.ASU_mode.setValue(mode);
  for (var room in rooms) {
    for (var projector in room.projectors) {
      print(projector.ip.toString() + '(ASU)');
      // checkConnectionProjector(projector);
      sendTCPIPCommand(projector, '(ASU)');
    }
  }
}

void OSDMode(bool mode) {
  allRoom.OSD_mode.setValue(mode);
  for (var room in rooms) {
    for (var projector in room.projectors) {
      if (allRoom.OSD_mode.getValue()) {
        print(projector.ip.toString() + '(OSD 1)');
        // checkConnectionProjector(projector);
        sendTCPIPCommand(projector, '(OSD 1)');
      } else {
        print(projector.ip.toString() + '(OSD 0)');
        // checkConnectionProjector(projector);
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
        print(projector.ip.toString() + '(CLE 2)');
        // checkConnectionProjector(projector);
        sendTCPIPCommand(projector, '(CLE 2)');
      } else {
        print(projector.ip.toString() + '(CLE 0)');
        // checkConnectionProjector(projector);
        sendTCPIPCommand(projector, '(CLE 0)');
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
