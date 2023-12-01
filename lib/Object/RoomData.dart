import 'dart:convert';

import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/BrightSign.dart';
import 'package:responsive_dashboard/Object/Led.dart';
import 'package:responsive_dashboard/Object/Preset.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/Sensor.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/data/Shared_Prefs_Method.dart';
import 'package:responsive_dashboard/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valuable/valuable.dart';

class RoomData {
  bool power_room_projectors;
  bool shutter_room_projectors;
  bool isSelectedPlay;
  bool isSelectedStop;
  String nameUI;
  String nameDatabase;
  String map;
  String general;
  bool resolume;
  int current_preset;
  String roomVolumeId;
  // CollectionReference? roomVolumeCollection;

  // Constructor
  RoomData({
    required this.nameUI,
    required this.nameDatabase,
    required this.power_room_projectors,
    required this.shutter_room_projectors,
    required this.isSelectedPlay,
    required this.isSelectedStop,
    required this.map,
    required this.general,
    required this.resolume,
    required this.current_preset,
    required this.roomVolumeId,
    // required this.roomVolumeCollection,
  });

  Map<String, dynamic> toJson() => {
        'nameUI': nameUI,
        'nameDatabase': nameDatabase,
        'power_room_projectors': power_room_projectors,
        'shutter_room_projectors': shutter_room_projectors,
        'isSelectedPlay': isSelectedPlay,
        'isSelectedStop': isSelectedStop,
        'map': map,
        'general': general,
        'resolume': resolume,
        'current_preset': current_preset,
        'roomVolumeId': roomVolumeId,
      };

  factory RoomData.fromJson(Map<String, dynamic> json) {
    return RoomData(
      nameUI: json['nameUI'],
      nameDatabase: json['nameDatabase'],
      power_room_projectors: json['power_room_projectors'],
      shutter_room_projectors: json['shutter_room_projectors'],
      isSelectedPlay: json['isSelectedPlay'],
      isSelectedStop: json['isSelectedStop'],
      map: json['map'],
      general: json['general'],
      resolume: json['resolume'],
      current_preset: json['current_preset'],
      roomVolumeId: json['roomVolumeId'],
    );
  }
}

final Future<RoomData> default_roomdata = Future.value(RoomData(
  nameUI: 'Room',
  nameDatabase: 'Volume P',
  power_room_projectors: false,
  shutter_room_projectors: false,
  isSelectedPlay: false,
  isSelectedStop: false,
  map: '',
  general: '',
  resolume: false,
  current_preset: 10,
  roomVolumeId: '',
));

Future<RoomData> getRoomData(String key) async {
  final SharedPreferences new_prefs = await prefs;
  final String? jsonString = new_prefs.getString(key);
  if (jsonString != null) {
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return RoomData.fromJson(jsonMap);
  } else {
    return default_roomdata;
  }
}

List<RoomData> getListRoom(SharedPreferences prefs) {
  List<RoomData> listRoom = [];

  // Lấy danh sách các key trong SharedPreferences
  Set<String> keys = prefs.getKeys();

  // Lọc những key có dạng 'projector_'
  List<String> projectorKeys =
      keys.where((key) => key.startsWith('room_')).toList();

  // Lặp qua từng key, đọc dữ liệu và kiểm tra trường 'room'
  for (String key in projectorKeys) {
    String? jsonString = prefs.getString(key);
    if (jsonString != null) {
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      RoomData roomData = RoomData.fromJson(jsonMap);
      listRoom.add(roomData);
    }
  }
  print(listRoom.length);
  return listRoom;
}

Future<void> deleteRoomData(String key) async {
  final SharedPreferences new_prefs = await prefs;
  await new_prefs.remove(key);
}

Future<void> addNewRoomData(RoomData new_Room) async {
  final SharedPreferences new_prefs = await prefs;
  List<String> Keys = [];
  int number = 0;
  Keys = new_prefs.getKeys().where((key) => key.startsWith('room_')).toList();
  if (Keys.length != 0) {
    // Sử dụng biểu thức chính quy để tìm số trong chuỗi
    RegExp regExp = RegExp(r'\d+');
    Match match = regExp.firstMatch(Keys.last)!;
    // Lấy chuỗi số từ kết quả tìm kiếm
    String numberString = match.group(0)!;
    // Chuyển chuỗi số thành số nguyên
    number = int.parse(numberString);
  }
  String newKey = 'room_${number + 1}';
  print(newKey);
  new_prefs.setString(newKey, json.encode(new_Room.toJson()));
}
