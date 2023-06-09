import 'package:responsive_dashboard/Method/ping_check_connection.dart';
import 'package:responsive_dashboard/Method/projector_command.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:valuable/valuable.dart';

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

void TestPatternSelect(Projector projector, StatefulValuable<int> num ) {
  checkConnectionProjector(projector);
  String response = sendTCPIPCommand(projector, '(ITP ${num.getValue()})');
  print(response);
}

//
// void LampStatus(Projector projector) {
//   sendPJLinkCommand(projector, '(%1LAMP ?)');
// }
