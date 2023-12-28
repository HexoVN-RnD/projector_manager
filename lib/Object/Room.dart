import 'dart:convert';

// import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Led.dart';
import 'package:responsive_dashboard/Object/Preset.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Sensor.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valuable/valuable.dart';

class Room {
  StatefulValuable<bool> power_room_projectors;
  StatefulValuable<bool> shutter_room_projectors;
  StatefulValuable<bool> isSelectedPlay;
  StatefulValuable<bool> isSelectedStop;
  String nameUI;
  String nameDatabase;
  String map;
  String general;
  bool resolume;
  List<Sensor> sensors;
  List<Led> leds;
  StatefulValuable<int> current_preset;
  List<Preset> presets; // : 1,2,3
  List<Projector> projectors;
  List<Server> servers;
  double roomVolumeFB;
  // CollectionReference roomVolumeCollection;
  StatefulValuable<String> roomVolumeId;

  // Constructor
  Room({
    required this.nameUI,
    required this.nameDatabase,
    required this.power_room_projectors,
    required this.shutter_room_projectors,
    required this.isSelectedPlay,
    required this.isSelectedStop,
    required this.map,
    required this.general,
    required this.resolume,
    required this.sensors,
    required this.leds,
    required this.current_preset,
    required this.presets,
    required this.projectors,
    required this.servers,
    required this.roomVolumeFB,
    // required this.roomVolumeCollection,
    required this.roomVolumeId,
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

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
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
      sensors: json['sensor'],
      leds: json['leds'],
      presets: json['presets'],
      projectors: json['projectors'],
      servers: json['servers'],
      roomVolumeFB: json['roomVolumeFB'],
    );
  }

  // Future<void> addNewRoom(Room new_Room) async {
  //   final SharedPreferences new_prefs = await prefs;
  //   List<String> Keys = [];
  //   int number = 0;
  //   Keys = new_prefs.getKeys().where((key) => key.startsWith('room_')).toList();
  //   if (Keys.length != 0) {
  //     // Sử dụng biểu thức chính quy để tìm số trong chuỗi
  //     RegExp regExp = RegExp(r'\d+');
  //     Match match = regExp.firstMatch(Keys.last)!;
  //     // Lấy chuỗi số từ kết quả tìm kiếm
  //     String numberString = match.group(0)!;
  //     // Chuyển chuỗi số thành số nguyên
  //     number = int.parse(numberString);
  //   }
  //   String newKey = 'room_${number + 1}';
  //   print('add room: '+ newKey);
  //   new_prefs.setString(newKey, json.encode(new_Room.toJson()));
  // }
}

Future<void> updateRoom(Room new_Room, String key) async {
  final SharedPreferences new_prefs = await prefs;
  print('update room: ' + key);
  new_prefs.setString(key, json.encode(new_Room.toJson()));
}

Future<void> deleteRoom(String key) async {
  final SharedPreferences new_prefs = await prefs;
  print('delete room: ' + key);
  await new_prefs.remove(key);
}
