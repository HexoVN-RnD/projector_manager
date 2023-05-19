import 'dart:io';

import 'package:dart_ping/dart_ping.dart';
import 'package:responsive_dashboard/Method/networkAddress.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:valuable/valuable.dart';

void checkServerPing(String serverIP, StatefulValuable<bool> connected) {
  // serverIP = '192.168.1.15';
  final ping = Ping(serverIP, count: 4); // Thay đổi số lần ping tùy ý

  ping.stream.listen((event) {
    print('Ping to $serverIP: ${event.response?.time} ms');
    if (event.response != null) {
      connected.setValue(true);
      ping.stop();
    } else if (event.runtimeType == PingError){
      connected.setValue(false);
    }
  });

  ping.command;
}


void CheckConnectStatus(String ip) async {
  try{
    final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
    socket.broadcastEnabled = true;

    // Gửi dữ liệu qua socket UDP đến server
    socket.send('ping'.codeUnits, InternetAddress('192.168.3.108'), 9);

    // Đặt thười gian chờ để nhận phản hồi từ server
    socket.timeout(Duration(seconds: 5));

    //Lắng nghe phản hồi từ server
    final response = await socket.receive();

    //Kiểm tra phản hồi từ server
    if(response!=null){
      print(ip+ 'true');
    } else {
      print(ip+ ' false');
    }

  } catch (e){
    print('Lỗi kiểm tra kết nối với server: $e');
  }
}



void CheckAllConnectionOpening() {
  print(current_page.getValue());
}

void CheckRoomConnection() {
  print(current_page.getValue());
}

Future<void> check_connection2(String ip, StatefulValuable<bool> connection) async {
  try {
    final socket = await Socket.connect(ip, 1000);
    print('connected');
    socket.destroy();
  } catch (e){
    print('Failed to connect: $e');
  }
}


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