import 'package:responsive_dashboard/Method/ping_check_connection.dart';
import 'package:responsive_dashboard/Method/projector_command.dart';
import 'package:responsive_dashboard/Method/projector_void.dart';
import 'package:responsive_dashboard/Object/Projector.dart';

Future<void> PowerModeProjector(Projector projector) async {
  if (projector.power_status_button.getValue() &&
      projector.power_status.getValue() !=
          projector.power_status_button.getValue()) {
    if (projector.type == 'Christie') {
      print(projector.ip.toString() + '(PWR 1)');
      // checkConnectionProjector(projector);
      sendTCPIPCommand(projector, '(PWR 1)');
    } else {
      print(projector.ip.toString() + '%1POWR 1[CR]');
      // checkConnectionProjector(projector);
      sendPJLinkCommand(projector, '%1POWR 1[CR]');
    }
  } else {
    if (projector.type == 'Christie') {
      print(projector.ip.toString() + '(PWR 0)');
      // checkConnectionProjector(projector);
      sendTCPIPCommand(projector, '(PWR 0)');
    } else {
      print(projector.ip.toString() + '%1POWR 0[CR]');
      // checkConnectionProjector(projector);
      sendPJLinkCommand(projector, '%1POWR 0[CR]');

      // }
    }
  }
  projector.power_status_button
      .setValue(!projector.power_status_button.getValue());

  // print("Starting...");
  // await Future.delayed(Duration(seconds: 30));
  // print("30 seconds have passed!");
  // PowerStatus(projector);
}

Future<void> ShutterModeProjector(Projector projector) async {
  if (projector.shutter_status_button.getValue() &&
      projector.shutter_status.getValue() !=
          projector.shutter_status_button.getValue()) {
    if (projector.type == 'Christie') {
      print(projector.ip.toString() + '(SHU 0)');
      // checkConnectionProjector(projector);
      sendTCPIPCommand(projector, '(SHU 0)');
    } else {
      print(projector.ip.toString() + '%1AVMT 30[CR]');
      // checkConnectionProjector(projector);
      sendPJLinkCommand(projector, '%1AVMT 30[CR]');
    }
  } else {
    if (projector.type == 'Christie') {
      print(projector.ip.toString() + '(SHU 1)');
      // checkConnectionProjector(projector);
      sendTCPIPCommand(projector, '(SHU 1)');
    } else {
      print(projector.ip.toString() + '%1AVMT 31[CR]');
      // checkConnectionProjector(projector);
      sendPJLinkCommand(projector, '%1AVMT 31[CR]');
    }
  }
  projector.shutter_status_button
      .setValue(!projector.shutter_status_button.getValue());
  print("Starting...");
  await Future.delayed(Duration(seconds: 10));
  print("30 seconds have passed!");
  ShutterStatus(projector);
}

Future<void> PowerOnProjector(Projector projector) async {
  if (projector.type == 'Christie') {
    print(projector.ip.toString() + '(PWR 0)');
    // checkConnectionProjector(projector);
    sendTCPIPCommand(projector, '(PWR 0)');
  } else {
    print(projector.ip.toString() + '%1POWR 0[CR]');
    // checkConnectionProjector(projector);
    sendPJLinkCommand(projector, '%1POWR 0[CR]');

    // }
  }
  projector.power_status_button
      .setValue(!projector.power_status_button.getValue());

  // print("Starting...");
  // await Future.delayed(Duration(seconds: 30));
  // print("30 seconds have passed!");
  // PowerStatus(projector);
}

Future<void> PowerOffProjector(Projector projector) async {
  if (projector.type == 'Christie') {
    print(projector.ip.toString() + '(PWR 1)');
    // checkConnectionProjector(projector);
    sendTCPIPCommand(projector, '(PWR 1)');
  } else {
    print(projector.ip.toString() + '%1POWR 1[CR]');
    // checkConnectionProjector(projector);
    sendPJLinkCommand(projector, '%1POWR 1[CR]');
  }
  projector.power_status_button
      .setValue(!projector.power_status_button.getValue());

  // print("Starting...");
  // await Future.delayed(Duration(seconds: 30));
  // print("30 seconds have passed!");
  // PowerStatus(projector);
}

Future<void> ShutterOnProjector(Projector projector) async {
  if (projector.type == 'Christie') {
    print(projector.ip.toString() + '(SHU 0)');
    // checkConnectionProjector(projector);
    sendTCPIPCommand(projector, '(SHU 0)');
  } else {
    print(projector.ip.toString() + '%1AVMT 30[CR]');
    // checkConnectionProjector(projector);
    sendPJLinkCommand(projector, '%1AVMT 30[CR]');
  }

  projector.shutter_status_button
      .setValue(!projector.shutter_status_button.getValue());
  print("Starting...");
  await Future.delayed(Duration(seconds: 10));
  print("30 seconds have passed!");
  ShutterStatus(projector);
}

Future<void> ShutterOffProjector(Projector projector) async {
  if (projector.type == 'Christie') {
    print(projector.ip.toString() + '(SHU 1)');
    // checkConnectionProjector(projector);
    sendTCPIPCommand(projector, '(SHU 1)');
  } else {
    print(projector.ip.toString() + '%1AVMT 31[CR]');
    // checkConnectionProjector(projector);
    sendPJLinkCommand(projector, '%1AVMT 31[CR]');
  }
  projector.shutter_status_button
      .setValue(!projector.shutter_status_button.getValue());
  print("Starting...");
  await Future.delayed(Duration(seconds: 10));
  print("30 seconds have passed!");
  ShutterStatus(projector);
}

void TestPatternSelect(Projector projector, int num) {
  projector.current_test_pattern.setValue(num);
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

void LampMode(Projector projector, int num) {
  projector.lamp_mode.setValue(num);
  if (num == 0) {
    projector.A1.setValue(true);
    projector.A2.setValue(true);
    projector.A3.setValue(true);
    projector.B1.setValue(true);
    projector.B2.setValue(true);
    projector.B3.setValue(true);
    print(projector.ip.toString() + '(LOP+MULT 63)');
    // checkConnectionProjector(projector);
    sendTCPIPCommand(projector, '(LOP+MULT 63))');
  } else if (num == 1) {
    projector.A1.setValue(true);
    projector.A2.setValue(true);
    projector.A3.setValue(true);
    projector.B1.setValue(false);
    projector.B2.setValue(false);
    projector.B3.setValue(false);
    print(projector.ip.toString() + '(LOP+MULT 7)');
    // checkConnectionProjector(projector);
    sendTCPIPCommand(projector, '(LOP+MULT 7)');
  } else if (num == 2) {
    projector.A1.setValue(false);
    projector.A2.setValue(false);
    projector.A3.setValue(false);
    projector.B1.setValue(true);
    projector.B2.setValue(true);
    projector.B3.setValue(true);
    print(projector.ip.toString() + '(LOP+MULT 56)');
    // checkConnectionProjector(projector);
    sendTCPIPCommand(projector, '(LOP+MULT 56)');
  } else if (num == 3) {
    projector.A1.setValue(true);
    projector.A2.setValue(false);
    projector.A3.setValue(false);
    projector.B1.setValue(true);
    projector.B2.setValue(false);
    projector.B3.setValue(false);
    print(projector.ip.toString() + '(LOP+MULT 9)');
    // checkConnectionProjector(projector);
    sendTCPIPCommand(projector, '(LOP+MULT 9)');
  } else if (num == 4) {
    projector.A1.setValue(false);
    projector.A2.setValue(true);
    projector.A3.setValue(false);
    projector.B1.setValue(false);
    projector.B2.setValue(true);
    projector.B3.setValue(false);
    print(projector.ip.toString() + '(LOP+MULT 18)');
    // checkConnectionProjector(projector);
    sendTCPIPCommand(projector, '(LOP+MULT 18)');
  } else if (num == 5) {
    projector.A1.setValue(false);
    projector.A2.setValue(false);
    projector.A3.setValue(true);
    projector.B1.setValue(false);
    projector.B2.setValue(false);
    projector.B3.setValue(true);
    print(projector.ip.toString() + '(LOP+MULT 36)');
    // checkConnectionProjector(projector);
    sendTCPIPCommand(projector, '(LOP+MULT 36)');
  }
  // for (var room in rooms) {
  //   for (var projector in room.projectors) {
  //     print(projector.ip.toString() + '(LMP $num)');
  //     // checkConnectionProjector(projector);
  //     sendTCPIPCommand(projector, '(LMP $num)');
  //   }
  // }
}

void ElectronicMode(Projector projector, bool mode) {
  projector.electronic_mode.setValue(mode);
  if (projector.electronic_mode.getValue()) {
    print(projector.ip.toString() + '(PWR+ELEC 1)');
    // checkConnectionProjector(projector);
    sendTCPIPCommand(projector, '(PWR+ELEC 1)');
  } else {
    print(projector.ip.toString() + '(PWR+ELEC 0)');
    // checkConnectionProjector(projector);
    sendTCPIPCommand(projector, '(PWR+ELEC 0)');
  }
}

void ASUMode(Projector projector) {
  projector.ASU_mode.setValue(true);
  print(projector.ip.toString() + '(ASU)');
  // checkConnectionProjector(projector);
  sendTCPIPCommand(projector, '(ASU)');
}

void OSDMode(Projector projector, bool mode) {
  projector.OSD_mode.setValue(mode);
  if (projector.OSD_mode.getValue()) {
    print(projector.ip.toString() + '(OSD 1)');
    // checkConnectionProjector(projector);
    sendTCPIPCommand(projector, '(OSD 1)');
  } else {
    print(projector.ip.toString() + '(OSD 0)');
    // checkConnectionProjector(projector);
    sendTCPIPCommand(projector, '(OSD 0)');
  }
}

void WhiteOrGreenMode(Projector projector, bool mode) {
  projector.whiteOrGreen.setValue(mode);
  if (projector.whiteOrGreen.getValue()) {
    print(projector.ip.toString() + '(CLE 2)');
    // checkConnectionProjector(projector);
    sendTCPIPCommand(projector, '(CLE 2)');
  } else {
    print(projector.ip.toString() + '(CLE 0)');
    // checkConnectionProjector(projector);
    sendTCPIPCommand(projector, '(CLE 0)');
  }
}
