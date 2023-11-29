import 'dart:convert';

import 'package:responsive_dashboard/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  double position_x;
  double position_y;
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
    required this.position_x,
    required this.position_y,
    required this.power_status,
    required this.volume,
    required this.connected,
    required this.isOnHover,
  });

  // Convert BrightSign object to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'ip': ip,
        'name': name,
        'shotname': shotname,
        'preset_port': preset_port,
        'power_port': power_port,
        'mac_address': mac_address,
        'password': password,
        'position_x': position_x,
        'position_y': position_y,
        'power_status': power_status,
        'volume': volume,
        'connected': connected,
        'isOnHover': isOnHover,
      };

  // Factory constructor to create a BrightSign from a JSON map
  factory BrightSign.fromJson(Map<String, dynamic> json) {
    return BrightSign(
      id: json['id'] ?? 0,
      ip: json['ip'] ?? 'defaultIP',
      name: json['name'] ?? 'defaultName',
      shotname: json['shotname'] ?? 'defaultShotname',
      preset_port: json['preset_port'] ?? 0,
      power_port: json['power_port'] ?? 0,
      mac_address: json['mac_address'] ?? 'defaultMacAddress',
      password: json['password'] ?? 'defaultPassword',
      position_x: json['position_x'] ?? 0.0,
      position_y: json['position_y'] ?? 0.0,
      power_status: json['power_status'] ?? false,
      volume: json['volume'] ?? 0.0,
      connected: json['connected'] ?? false,
      isOnHover: json['isOnHover'] ?? false,
    );
  }
}

// Similar to getSensor function for Sensor class
Future<BrightSign> getBrightSign(String key) async {
  final SharedPreferences newPrefs = await prefs;
  final String? jsonString = newPrefs.getString(key);
  if (jsonString != null) {
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return BrightSign.fromJson(jsonMap);
  } else {
    return defaultBrightSign;
  }
}

// Similar to deleteSensor function for Sensor class
Future<void> deleteBrightSign(String key) async {
  final SharedPreferences newPrefs = await prefs;
  await newPrefs.remove(key);
}

// Similar to setNewSensor function for Sensor class
Future<void> setNewBrightSign(BrightSign newBrightSign, String newKey) async {
  final SharedPreferences newPrefs = await prefs;
  newPrefs.setString(newKey, json.encode(newBrightSign.toJson()));
}

// Default BrightSign
final Future<BrightSign> defaultBrightSign = Future.value(
  BrightSign(
    id: 0,
    ip: 'defaultIP',
    name: 'defaultName',
    shotname: 'defaultShotname',
    preset_port: 0,
    power_port: 0,
    mac_address: 'defaultMacAddress',
    password: 'defaultPassword',
    position_x: 0.0,
    position_y: 0.0,
    power_status: false,
    volume: 0.0,
    connected: false,
    isOnHover: false,
  ),
);
