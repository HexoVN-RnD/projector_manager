import 'package:flutter/material.dart';
import 'package:valuable/valuable.dart';

class BrightSign {
  int id;
  String ip;
  String name;
  String shotname;
  int preset_port;
  int power_port;
  String mac_address;
  String password;
  bool power_status;
  Offset position;
  double volume;
  bool connected;
  bool isOnHover;

  // Constructor
  BrightSign({
    required this.id,
    required this.ip,
    required this.name,
    required this.shotname,
    required this.preset_port,
    required this.power_port,
    required this.mac_address,
    required this.password,
    required this.position,
    required this.power_status,
    required this.volume,
    required this.connected,
    required this.isOnHover,
  });
}
