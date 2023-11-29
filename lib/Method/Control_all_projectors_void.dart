import 'package:responsive_dashboard/Method/ping_check_connection.dart';
import 'package:responsive_dashboard/Method/projector_command.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/data/data.dart';

// void select_preset(int index) async {
//   allRoom.current_preset=index);
//   for (Room room in rooms) {
//     room.current_preset=index);
//   }
// }
void SetButtonControlAllSystem(){
  int numProjectorPowerOn = 0;
  int numProjectorShutterOn = 0;
  int numServerPowerOn = 0;
  for (Room room in rooms){
    for(Server server in room.servers!){
      if(server.connected){
        numServerPowerOn++;
      }
    }
    for (Projector projector in room.projectors!) {
      if (projector.power_status) {
        numProjectorPowerOn++;
      }
      if (projector.shutter_status){
        numProjectorShutterOn++;
      }
    }
  }
  if(allRoom.num_projectors == numProjectorPowerOn){
    allRoom.power_all_projectors=true;
  } else if(numProjectorPowerOn==0) {
    allRoom.power_all_projectors=false;
  }
  if(allRoom.num_projectors == numProjectorShutterOn){
    allRoom.shutter_all_projectors=true;
  } else if(numProjectorShutterOn==0){
    allRoom.shutter_all_projectors=false;
  }
  if(allRoom.num_servers == numServerPowerOn){
    allRoom.power_all_servers=true;
  } else if(numServerPowerOn == 0){
    allRoom.power_all_servers=false;
  }
}

void SetButtonControlRoom(Room room){
  int numProjectorPowerOn = 0;
  int numProjectorShutterOn = 0;
    for (Projector projector in room.projectors!) {
      if (projector.power_status) {
        numProjectorPowerOn++;
      }
      if (projector.shutter_status){
        numProjectorShutterOn++;
      }
    }
  if(room.projectors!.length == numProjectorPowerOn){
    room.power_room_projectors=true;
  } else if(numProjectorPowerOn==0) {
    room.power_room_projectors=false;
  }
  if(room.projectors!.length == numProjectorShutterOn){
    room.shutter_room_projectors=true;
  } else if(numProjectorShutterOn==0){
    room.shutter_room_projectors=false;
  }
}

void PowerAllProjectors(bool mode) async {
  allRoom.power_all_projectors=mode;
  for (var room in rooms) {
    for (var projector in room.projectors!) {
      checkConnectionProjector(projector);
    }
  }
  await Future.delayed(Duration(seconds: 1));
  for (var room in rooms) {
    for (var projector in room.projectors!) {
      // if (projector.power_status_button !=
      //     allRoom.power_all_projectors) {
      // checkConnectionProjector(projector);
      if (projector.power_status != mode) {
        projector.power_status
            =allRoom.power_all_projectors;
        if (mode) {
          if (projector.type == 'Christie') {
            print(projector.ip.toString() + '(PWR 1)');
            // checkConnectionProjector(projector);
            sendTCPIPCommandNoResponse(projector, '(PWR 1)');
            await Future.delayed(Duration(seconds: 5));
          } else {
            print(projector.ip.toString() + '%1POWR 1[CR]');
            // checkConnectionProjector(projector);
            sendPJLinkCommandNoResponse(projector, '%1POWR 1[CR]');
            await Future.delayed(Duration(seconds: 5));
          }
        } else {
          if (projector.type == 'Christie') {
            print(projector.ip.toString() + '(PWR 0)');
            // checkConnectionProjector(projector);
            sendTCPIPCommandNoResponse(projector, '(PWR 0)');
          } else {
            print(projector.ip.toString() + '%1POWR 0[CR]');
            // checkConnectionProjector(projector);
            sendPJLinkCommandNoResponse(projector, '%1POWR 0[CR]');
            // }
          }
        }
      } else {
        print('Disconnect');
      }
    }
  }
}

void PowerRoomProjectors(Room room, bool mode) async {
  room.power_room_projectors=mode;
    for (var projector in room.projectors!) {
      checkConnectionProjector(projector);
    }
  await Future.delayed(Duration(seconds: 1));
    for (var projector in room.projectors!) {
      if (projector.power_status != mode) {
        projector.power_status
            =room.power_room_projectors;
        if (mode) {
          if (projector.type == 'Christie') {
            print(projector.ip.toString() + '(PWR 1)');
            // checkConnectionProjector(projector);
            sendTCPIPCommandNoResponse(projector, '(PWR 1)');
            await Future.delayed(Duration(seconds: 5));
          } else {
            print(projector.ip.toString() + '%1POWR 1[CR]');
            // checkConnectionProjector(projector);
            sendPJLinkCommandNoResponse(projector, '%1POWR 1[CR]');
            await Future.delayed(Duration(seconds: 5));
          }
        } else {
          if (projector.type == 'Christie') {
            print(projector.ip.toString() + '(PWR 0)');
            // checkConnectionProjector(projector);
            sendTCPIPCommandNoResponse(projector, '(PWR 0)');
          } else {
            print(projector.ip.toString() + '%1POWR 0[CR]');
            // checkConnectionProjector(projector);
            sendPJLinkCommandNoResponse(projector, '%1POWR 0[CR]');
            // }
          }
        }
      } else {
        print('Disconnect');
      }
    }
}

void ShutterAllProjectors(bool mode) {
  allRoom.shutter_all_projectors=mode;
  for (var room in rooms) {
    for (var projector in room.projectors!) {
      if (mode) {
        if (projector.type == 'Christie') {
          print(projector.ip.toString() + '(SHU 1)');
          // checkConnectionProjector(projector);
          sendTCPIPCommandNoResponse(projector, '(SHU 1)');
        } else {
          print(projector.ip.toString() + '%1AVMT 31[CR]');
          // checkConnectionProjector(projector);
          sendPJLinkCommandNoResponse(projector, '%1AVMT 31[CR]');
        }
      } else {
        if (projector.type == 'Christie') {
          print(projector.ip.toString() + '(SHU 0)');
          // checkConnectionProjector(projector);
          sendTCPIPCommandNoResponse(projector, '(SHU 0)');
        } else {
          print(projector.ip.toString() + '%1AVMT 30[CR]');
          // checkConnectionProjector(projector);
          sendPJLinkCommandNoResponse(projector, '%1AVMT 30[CR]');
        }
      }
      projector.shutter_status
          =allRoom.shutter_all_projectors;
    }
  }
}

void ShutterRoomProjectors(Room room,bool mode) {
  room.shutter_room_projectors=mode;
  for (var projector in room.projectors!) {
      if (mode) {
        if (projector.type == 'Christie') {
          print(projector.ip.toString() + '(SHU 1)');
          // checkConnectionProjector(projector);
          sendTCPIPCommandNoResponse(projector, '(SHU 1)');
        } else {
          print(projector.ip.toString() + '%1AVMT 31[CR]');
          // checkConnectionProjector(projector);
          sendPJLinkCommandNoResponse(projector, '%1AVMT 31[CR]');
        }
      } else {
        if (projector.type == 'Christie') {
          print(projector.ip.toString() + '(SHU 0)');
          // checkConnectionProjector(projector);
          sendTCPIPCommandNoResponse(projector, '(SHU 0)');
        } else {
          print(projector.ip.toString() + '%1AVMT 30[CR]');
          // checkConnectionProjector(projector);
          sendPJLinkCommandNoResponse(projector, '%1AVMT 30[CR]');
        }
      }
      projector.shutter_status
          = allRoom.shutter_all_projectors;
    }
}

// void TestPatternSelectAll(int num) {
//   allRoom.current_test_pattern=num);
//   for (var room in rooms) {
//     for (var projector in room.projectors) {
//       // checkConnectionProjector(projector);
//       projector.current_test_pattern=num);
//       if (num == 0) {
//         print(projector.ip.toString() + '(ITP 0)');
//         sendTCPIPCommand(projector, '(ITP 0)');
//       } else if (num == 1) {
//         print(projector.ip.toString() + '(ITP 1)');
//         sendTCPIPCommand(projector, '(ITP 1)');
//       } else if (num == 2) {
//         print(projector.ip.toString() + '(ITP 3)');
//         sendTCPIPCommand(projector, '(ITP 3)');
//       } else if (num == 3) {
//         print(projector.ip.toString() + '(ITP 5)');
//         sendTCPIPCommand(projector, '(ITP 5)');
//       } else if (num == 4) {
//         print(projector.ip.toString() + '(ITP 9)');
//         sendTCPIPCommand(projector, '(ITP 9)');
//       }
//     }
//   }
// }

// void LampModeAll(int num) {
//   allRoom.lamp_mode=num);
//   if (num == 0) {
//     allRoom.A1=true);
//     allRoom.A2=true);
//     allRoom.A3=true);
//     allRoom.B1=true);
//     allRoom.B2=true);
//     allRoom.B3=true);
//     for (var room in rooms) {
//       for (var projector in room.projectors) {
//         print(projector.ip.toString() + '(LOP+MULT 63)');
//         // checkConnectionProjector(projector);
//         sendTCPIPCommand(projector, '(LOP+MULT 63))');
//       }
//     }
//   } else if (num == 1) {
//     allRoom.A1=true);
//     allRoom.A2=true);
//     allRoom.A3=true);
//     allRoom.B1=false);
//     allRoom.B2=false);
//     allRoom.B3=false);
//     for (var room in rooms) {
//       for (var projector in room.projectors) {
//         print(projector.ip.toString() + '(LOP+MULT 7)');
//         // checkConnectionProjector(projector);
//         sendTCPIPCommand(projector, '(LOP+MULT 7)');
//       }
//     }
//   } else if (num == 2) {
//     allRoom.A1=false);
//     allRoom.A2=false);
//     allRoom.A3=false);
//     allRoom.B1=true);
//     allRoom.B2=true);
//     allRoom.B3=true);
//     for (var room in rooms) {
//       for (var projector in room.projectors) {
//         print(projector.ip.toString() + '(LOP+MULT 56)');
//         // checkConnectionProjector(projector);
//         sendTCPIPCommand(projector, '(LOP+MULT 56)');
//       }
//     }
//   } else if (num == 3) {
//     allRoom.A1=true);
//     allRoom.A2=false);
//     allRoom.A3=false);
//     allRoom.B1=true);
//     allRoom.B2=false);
//     allRoom.B3=false);
//     for (var room in rooms) {
//       for (var projector in room.projectors) {
//         print(projector.ip.toString() + '(LOP+MULT 9)');
//         // checkConnectionProjector(projector);
//         sendTCPIPCommand(projector, '(LOP+MULT 9)');
//       }
//     }
//   } else if (num == 4) {
//     allRoom.A1=false);
//     allRoom.A2=true);
//     allRoom.A3=false);
//     allRoom.B1=false);
//     allRoom.B2=true);
//     allRoom.B3=false);
//     for (var room in rooms) {
//       for (var projector in room.projectors) {
//         print(projector.ip.toString() + '(LOP+MULT 18)');
//         // checkConnectionProjector(projector);
//         sendTCPIPCommand(projector, '(LOP+MULT 18)');
//       }
//     }
//   } else if (num == 5) {
//     allRoom.A1=false);
//     allRoom.A2=false);
//     allRoom.A3=true);
//     allRoom.B1=false);
//     allRoom.B2=false);
//     allRoom.B3=true);
//     for (var room in rooms) {
//       for (var projector in room.projectors) {
//         print(projector.ip.toString() + '(LOP+MULT 36)');
//         // checkConnectionProjector(projector);
//         sendTCPIPCommand(projector, '(LOP+MULT 36)');
//       }
//     }
//   }
//   // for (var room in rooms) {
//   //   for (var projector in room.projectors) {
//   //     print(projector.ip.toString() + '(LMP $num)');
//   //     // checkConnectionProjector(projector);
//   //     sendTCPIPCommand(projector, '(LMP $num)');
//   //   }
//   // }
// }

// void ElectronicModeAll(bool mode) {
//   allRoom.electronic_mode=mode);
//   for (var room in rooms) {
//     for (var projector in room.projectors) {
//       if (allRoom.electronic_mode) {
//         print(projector.ip.toString() + '(PWR+ELEC 1)');
//         // checkConnectionProjector(projector);
//         sendTCPIPCommand(projector, '(PWR+ELEC 1)');
//       } else {
//         print(projector.ip.toString() + '(PWR+ELEC 0)');
//         // checkConnectionProjector(projector);
//         sendTCPIPCommand(projector, '(PWR+ELEC 0)');
//       }
//     }
//   }
// }

// void ASUModeAll() {
//   allRoom.ASU_mode=true);
//   for (var room in rooms) {
//     for (var projector in room.projectors) {
//       print(projector.ip.toString() + '(ASU)');
//       // checkConnectionProjector(projector);
//       sendTCPIPCommand(projector, '(ASU)');
//     }
//   }
// }

// void OSDModeAll(bool mode) {
//   allRoom.OSD_mode=mode);
//   for (var room in rooms) {
//     for (var projector in room.projectors) {
//       if (allRoom.OSD_mode) {
//         print(projector.ip.toString() + '(OSD 1)');
//         // checkConnectionProjector(projector);
//         sendTCPIPCommand(projector, '(OSD 1)');
//       } else {
//         print(projector.ip.toString() + '(OSD 0)');
//         // checkConnectionProjector(projector);
//         sendTCPIPCommand(projector, '(OSD 0)');
//       }
//     }
//   }
// }

// void WhiteOrGreenModeAll(bool mode) {
//   allRoom.whiteOrGreen=mode);
//   for (var room in rooms) {
//     for (var projector in room.projectors) {
//       if (allRoom.whiteOrGreen) {
//         print(projector.ip.toString() + '(CLE 2)');
//         // checkConnectionProjector(projector);
//         sendTCPIPCommand(projector, '(CLE 2)');
//       } else {
//         print(projector.ip.toString() + '(CLE 0)');
//         // checkConnectionProjector(projector);
//         sendTCPIPCommand(projector, '(CLE 0)');
//       }
//     }
//   }
// }

// void CheckLog(Projector projector) {
//   print(projector.ip.toString() + '(LOG?)');
//   String response = sendTCPIPCommand(projector, '(LOG?)');
//   projector.log=response);
// }
//
// void CheckLogRoom(Room room) {
//   for (var projector in room.projectors) {
//     print(projector.ip.toString() + '(LOG?)');
//     String response = sendTCPIPCommand(projector, '(LOG?)');
//     projector.log=response);
//   }
// }

// void PowerAllServers(bool mode) {
//   print(mode);
//   allRoom.power_all_servers=mode);
//   for (var room in rooms) {
//     for (var server in room.servers) {
//       server.power_status=allRoom.power_all_servers);
//     }
//   }
// }

// void ChangeAllVolume(double index) {
//   allRoom.volume_all=index);
//   for (var room in rooms) {
//     for (var server in room.servers) {
//       server.volume=index);
//     }
//   }
// }
