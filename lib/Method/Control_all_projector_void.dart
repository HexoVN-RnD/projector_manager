import 'package:responsive_dashboard/Method/ping_check_connection.dart';
import 'package:responsive_dashboard/Method/projector_command.dart';
import 'package:responsive_dashboard/Method/projector_void.dart';
import 'package:responsive_dashboard/Object/Projector.dart';

Future<void> PowerModeProjector(Projector projector) async {
  (projector.power_status_button.getValue() &&
          projector.power_status.getValue() !=
              projector.power_status_button.getValue())
      ? sendTCPIPCommand(projector, '(PWR 0)')
      : sendTCPIPCommand(projector, '(PWR 1)');
  projector.power_status_button
      .setValue(!projector.power_status_button.getValue());

  print("Starting...");
  await Future.delayed(Duration(seconds: 30));
  print("30 seconds have passed!");
  PowerStatus(projector);
}

Future<void> ShutterModeProjector(Projector projector) async {
  (projector.shutter_status_button.getValue() &&
      projector.shutter_status.getValue() !=
          projector.shutter_status_button.getValue())
      ? sendTCPIPCommand(projector, '(SHU 0)')
      : sendTCPIPCommand(projector, '(SHU 1)');
  projector.shutter_status_button
      .setValue(!projector.shutter_status_button.getValue());
  print("Starting...");
  await Future.delayed(Duration(seconds: 10));
  print("30 seconds have passed!");
  ShutterStatus(projector);
}

