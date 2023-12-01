import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:responsive_dashboard/main.dart';
import 'package:valuable/valuable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Projector {
  int room;
  String ip;
  String name;
  int port;
  String UsernameAndPassword;
  String type;
  bool power_status_button;
  bool shutter_status_button;
  bool connected;
  bool power_status;
  bool shutter_status;
  double lamp_hours;
  int status;
  double position_x;
  double position_y;
  bool color_state;
  bool isOnHover;

  // Constructor
  Projector({
    required this.room,
    required this.ip,
    required this.name,
    required this.port,
    required this.UsernameAndPassword,
    required this.type,
    required this.power_status_button,
    required this.shutter_status_button,
    required this.power_status,
    required this.shutter_status,
    required this.lamp_hours,
    required this.status,
    required this.connected,
    required this.position_x,
    required this.position_y,
    // this.lamp_hours = StatefulValuable<double>(0),
    required this.color_state,
    required this.isOnHover,
  });

  Map<String, dynamic> toJson() => {
        'room': room,
        'ip': ip,
        'name': name,
        'port': port,
        'UsernameAndPassword': UsernameAndPassword,
        'type': type,
        'power_status_button': power_status_button,
        'shutter_status_button': shutter_status_button,
        'connected': connected,
        'power_status': power_status,
        'shutter_status': shutter_status,
        'lamp_hours': lamp_hours,
        'status': status,
        'position_x': position_x,
        'position_y': position_y,
        'color_state': color_state,
        'isOnHover': isOnHover,
      };

  factory Projector.fromJson(Map<String, dynamic> json) {
    return Projector(
      room: json['room'],
      ip: json['ip'],
      name: json['name'],
      port: json['port'],
      UsernameAndPassword: json['UsernameAndPassword'],
      type: json['type'],
      power_status_button: json['power_status_button'],
      shutter_status_button: json['shutter_status_button'],
      connected: json['connected'],
      power_status: json['power_status'],
      shutter_status: json['shutter_status'],
      lamp_hours: json['lamp_hours'],
      status: json['status'],
      position_x: json['position_x'],
      position_y: json['position_y'],
      color_state: json['color_state'],
      isOnHover: json['isOnHover'],
    );
  }
}

//
// Future<Projector> getProjector(String keyPrefix) async {
//   final prefs = await SharedPreferences.getInstance();
//   final projectorJson = prefs.getString(keyPrefix);
//   if (projectorJson != null) {
//     final Map<String, dynamic> projectorMap = json.decode(projectorJson);
//     return Projector.fromJson(
//         projectorMap); // You need to implement fromJson constructor in your Projector class
//   } else {
//     // Handle the case where no projector is stored
//     throw Exception('No projector found in SharedPreferences');
//   }
// }
//
// Future<void> saveProjector(Projector projector, String keyPrefix) async {
//   final prefs = await SharedPreferences.getInstance();
//   prefs.setString(keyPrefix, json.encode(projector.toJson()));
// }
//
// Future<void> updateProjector(
//     Projector updatedProjector, String keyPrefix) async {
//   final prefs = await SharedPreferences.getInstance();
//   prefs.setString(keyPrefix, json.encode(updatedProjector.toJson()));
// }
//
// Future<void> deleteProjector(String keyPrefix) async {
//   final prefs = await SharedPreferences.getInstance();
//   prefs.remove(keyPrefix);
// }
final Future<Projector> default_projector = Future.value(Projector(
    room: 0,
    ip: '192.168.0.0',
    name: 'Projector',
    port: 3002,
    UsernameAndPassword: 'admin',
    type: 'PJlink',
    power_status_button: false,
    shutter_status_button: false,
    power_status: false,
    shutter_status: false,
    lamp_hours: 0,
    status: 0,
    connected: false,
    position_x: 0.0,
    position_y: 0.0,
    color_state: false,
    isOnHover: false));

Future<Projector> getProjector(String key) async {
  final SharedPreferences new_prefs = await prefs;
  final String? jsonString = new_prefs.getString(key);
  if (jsonString != null) {
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return Projector.fromJson(jsonMap);
  } else {
    return default_projector;
  }
}

Future<List<Projector>> getListProjector(int roomNumber) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<Projector> projectorsInRoom = [];

  // Lấy danh sách các key trong SharedPreferences
  Set<String> keys = prefs.getKeys();

  // Lọc những key có dạng 'projector_'
  List<String> projectorKeys =
      keys.where((key) => key.startsWith('projector_')).toList();

  // Lặp qua từng key, đọc dữ liệu và kiểm tra trường 'room'
  for (String key in projectorKeys) {
    String? jsonString = prefs.getString(key);
    if (jsonString != null) {
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      // Kiểm tra trường 'room'
      if (jsonMap['room'] == roomNumber) {
        Projector projector = Projector.fromJson(jsonMap);
        projectorsInRoom.add(projector);
      }
    }
  }
  print(projectorsInRoom.length);
  return projectorsInRoom;
}

List<Projector> getListProjector2(SharedPreferences prefs,int roomNumber) {
  List<Projector> projectorsInRoom = [];

  // Lấy danh sách các key trong SharedPreferences
  Set<String> keys = prefs.getKeys();

  // Lọc những key có dạng 'projector_'
  List<String> projectorKeys =
  keys.where((key) => key.startsWith('projector_')).toList();

  // Lặp qua từng key, đọc dữ liệu và kiểm tra trường 'room'
  for (String key in projectorKeys) {
    String? jsonString = prefs.getString(key);
    if (jsonString != null) {
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      // Kiểm tra trường 'room'
      if (jsonMap['room'] == roomNumber) {
        Projector projector = Projector.fromJson(jsonMap);
        projectorsInRoom.add(projector);
      }
    }
  }
  print(projectorsInRoom.length);
  return projectorsInRoom;
}

void addNewProjector(Projector new_projector) async {
  final SharedPreferences new_prefs = await prefs;
  List<String> Keys = [];
  int number = 0;
  Keys=new_prefs.getKeys().where((key) => key.startsWith('projector_')).toList();
  // Sử dụng biểu thức chính quy để tìm số trong chuỗi
  if (Keys.length != 0) {
    RegExp regExp = RegExp(r'\d+');
    Match match = regExp.firstMatch(Keys.last)!;
    // Lấy chuỗi số từ kết quả tìm kiếm
    String numberString = match.group(0)!;
    // Chuyển chuỗi số thành số nguyên
    number = int.parse(numberString);
  }

  String newKey = 'projector_${number + 1}';
  print(newKey);
  new_prefs.setString(newKey, json.encode(new_projector.toJson()));
}

void adjustProjector(Projector new_projector, String new_key) async {
  final SharedPreferences new_prefs = await prefs;
  new_prefs.setString(new_key, json.encode(new_projector.toJson()));
}
