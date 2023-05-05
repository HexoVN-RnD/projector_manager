import 'package:responsive_dashboard/Method/networkAddress.dart';
import 'package:valuable/valuable.dart';

void check_connection(String ip, StatefulValuable<bool> connection) {
  // NetworkAnalyzer.discover pings PORT:IP one by one according to timeout.
  // NetworkAnalyzer.discover2 pings all PORT:IP addresses at once.
  final stream = NetworkAnalyzer.discover2(
    ip,
    80,
    timeout: Duration(milliseconds: 5000),
  );
  print('Check Connecting...');
  stream.listen((NetworkAddress addr) {
    // print('${addr.ip}');
    if (addr.exists) {
      connection.setValue(true);
      print('Found device: ${addr.ip}');
    }
  }).onDone(() => print('Finish'));
}

void check_all_connection(String subnet) {
  // NetworkAnalyzer.discover pings PORT:IP one by one according to timeout.
  // NetworkAnalyzer.discover2 pings all PORT:IP addresses at once.

  const port = 80;
  final stream = NetworkAnalyzer.discover_all(
    subnet,
    port,
    timeout: Duration(milliseconds: 5000),
  );

  int found = 0;
  stream.listen((NetworkAddress addr) {
    // print('${addr.ip}:$port');
    if (addr.exists) {
      found++;
      print('Found device: ${addr.ip}:$port');
    }
  }).onDone(() => print('Finish. Found $found device(s)'));
}