import 'dart:convert';

import 'package:responsive_dashboard/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preset {
  String name;
  String image;
  String osc_message;
  double transport;

  // Constructor
  Preset({
    required this.name,
    required this.image,
    required this.osc_message,
    required this.transport,
  });

  // Convert Preset object to JSON
  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
        'osc_message': osc_message,
        'transport': transport,
      };

  // Factory constructor to create a Preset from a JSON map
  factory Preset.fromJson(Map<String, dynamic> json) {
    return Preset(
      name: json['name'] ?? 'defaultName',
      image: json['image'] ?? 'defaultImage',
      osc_message: json['osc_message'] ?? 'defaultOscMessage',
      transport: json['transport'] ?? 0.0,
    );
  }
}

// Similar to getSensor function for Sensor class
Future<Preset> getPreset(String key) async {
  final SharedPreferences newPrefs = await prefs;
  final String? jsonString = newPrefs.getString(key);
  if (jsonString != null) {
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return Preset.fromJson(jsonMap);
  } else {
    return defaultPreset;
  }
}

// Similar to deleteSensor function for Sensor class
Future<void> deletePreset(String key) async {
  final SharedPreferences newPrefs = await prefs;
  await newPrefs.remove(key);
}

// Similar to setNewSensor function for Sensor class
Future<void> setNewPreset(Preset newPreset, String newKey) async {
  final SharedPreferences newPrefs = await prefs;
  newPrefs.setString(newKey, json.encode(newPreset.toJson()));
}

// Default Preset
final Future<Preset> defaultPreset = Future.value(
  Preset(
    name: 'defaultName',
    image: 'defaultImage',
    osc_message: 'defaultOscMessage',
    transport: 0.0,
  ),
);
