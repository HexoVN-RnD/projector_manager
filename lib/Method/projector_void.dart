import 'package:responsive_dashboard/Method/ping_check_connection.dart';
import 'package:responsive_dashboard/Method/projector_command.dart';
import 'package:responsive_dashboard/Object/Projector.dart';

void PowerModeProjector(Projector projector) {
  projector.power_status_button.getValue()
      ? sendTCPIPCommand(projector, '(PWR 0)')
      : sendTCPIPCommand(projector, '(PWR 1)');
  projector.power_status_button
      .setValue(!projector.power_status_button.getValue());
  print(projector.ip +
      " " +
      projector.port.toString() +
      " PWR " +
      projector.power_status_button.getValue().toString());
}

void ShutterModeProjector(Projector projector) {
  projector.shutter_status_button.getValue()
      ? sendTCPIPCommand(projector, '(SHU 0)')
      : sendTCPIPCommand(projector, '(SHU 1)');
  projector.shutter_status_button
      .setValue(!projector.shutter_status_button.getValue());
  print(projector.ip +
      " " +
      projector.port.toString() +
      " SHU " +
      projector.shutter_status_button.getValue().toString());
}

void PowerStatus(Projector projector) {
  checkConnectionProjector(projector);
  String response = sendTCPIPCommand(projector, '(PWR?)');
  print(response);
}

void ShutterStatus(Projector projector) {
  checkConnectionProjector(projector);
  String response = sendTCPIPCommand(projector, '(SHU?)');
  print(response);
}

void LampStatus(Projector projector) {
  sendPJLinkCommand(projector, '(%1LAMP ?)');
  print(projector.ip +
      " " +
      projector.port.toString() +
      " PWR " +
      projector.power_status_button.getValue().toString());
}
