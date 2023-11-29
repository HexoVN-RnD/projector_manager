import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:responsive_dashboard/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valuable/valuable.dart';

class Sensor {
  String ip;
  String name;
  int port;
  bool connected;
  double position_x;
  double position_y;

  // Constructor
  Sensor({
    required this.ip,
    required this.name,
    required this.position_x,
    required this.position_y,
    required this.port,
    required this.connected,
  });

  // Convert Sensor object to JSON
  Map<String, dynamic> toJson() => {
        'ip': ip,
        'name': name,
        'position_x': position_x,
        'position_y': position_y,
        'port': port,
        'connected': connected,
      };

  // Factory constructor to create a Sensor from a JSON map
  factory Sensor.fromJson(Map<String, dynamic> json) {
    return Sensor(
      ip: json['ip'],
      name: json['name'],
      position_x: json['position_x'],
      position_y: json['position_y'],
      port: json['port'],
      connected: json['connected'],
    );
  }
}

// Default Sensor
final Future<Sensor> defaultSensor = Future.value(
  Sensor(
    ip: '192.168.1.1',
    name: 'Sensor 1',
    position_x: 0.0,
    position_y: 0.0,
    port: 0,
    connected: false,
  ),
);

// Similar to getRoom function for Room class
Future<Sensor> getSensor(String key) async {
  final SharedPreferences newPrefs = await prefs;
  final String? jsonString = newPrefs.getString(key);
  if (jsonString != null) {
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return Sensor.fromJson(jsonMap);
  } else {
    return defaultSensor;
  }
}

// Similar to deleteRoom function for Room class
Future<void> deleteSensor(String key) async {
  final SharedPreferences newPrefs = await prefs;
  await newPrefs.remove(key);
}

// Similar to setNewRoom function for Room class
Future<void> setNewSensor(Sensor newSensor, String newKey) async {
  final SharedPreferences newPrefs = await prefs;
  newPrefs.setString(newKey, json.encode(newSensor.toJson()));
}
