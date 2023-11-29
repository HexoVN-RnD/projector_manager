import 'dart:convert';

import 'package:responsive_dashboard/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Led {
  String ip;
  String name;
  int port;
  bool connected;
  double position_x;
  double position_y;

  // Constructor
  Led({
    required this.ip,
    required this.name,
    required this.position_x,
    required this.position_y,
    required this.port,
    required this.connected,
  });

  // Convert Led object to JSON
  Map<String, dynamic> toJson() => {
        'ip': ip,
        'name': name,
        'position_x': position_x,
        'position_y': position_y,
        'port': port,
        'connected': connected,
      };

  // Factory constructor to create a Led from a JSON map
  factory Led.fromJson(Map<String, dynamic> json) {
    return Led(
      ip: json['ip'] ?? 'defaultIP',
      name: json['name'] ?? 'defaultName',
      position_x: json['position_x'] ?? 0.0,
      position_y: json['position_y'] ?? 0.0,
      port: json['port'] ?? 0,
      connected: json['connected'] ?? false,
    );
  }
}

// Similar to getSensor function for Sensor class
Future<Led> getLed(String key) async {
  final SharedPreferences newPrefs = await prefs;
  final String? jsonString = newPrefs.getString(key);
  if (jsonString != null) {
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return Led.fromJson(jsonMap);
  } else {
    return defaultLed;
  }
}

// Similar to deleteSensor function for Sensor class
Future<void> deleteLed(String key) async {
  final SharedPreferences newPrefs = await prefs;
  await newPrefs.remove(key);
}

// Similar to setNewSensor function for Sensor class
Future<void> setNewLed(Led newLed, String newKey) async {
  final SharedPreferences newPrefs = await prefs;
  newPrefs.setString(newKey, json.encode(newLed.toJson()));
}

// Default Led
final Future<Led> defaultLed = Future.value(
  Led(
    ip: 'defaultIP',
    name: 'defaultName',
    position_x: 0.0,
    position_y: 0.0,
    port: 0,
    connected: false,
  ),
);
