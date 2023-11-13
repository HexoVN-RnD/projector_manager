import 'dart:convert';

import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Led.dart';
import 'package:responsive_dashboard/Object/Preset.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/Sensor.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valuable/valuable.dart';

class Room {
  bool power_room_projectors;
  bool shutter_room_projectors;
  bool isSelectedPlay;
  bool isSelectedStop;
  String nameUI;
  String nameDatabase;
  String map;
  String general;
  bool resolume;
  List<Sensor> sensors;
  List<Led> leds;
  int current_preset;
  List<Preset> presets; // : 1,2,3
  List<Projector> projectors;
  List<Server> servers;
  List<Document> roomVolumeFB;
  // CollectionReference roomVolumeCollection;
  String roomVolumeId;

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
        'sensors': sensors,
        'leds': leds,
        'current_preset': current_preset,
        'presets': presets,
        'projectors': projectors,
        'servers': servers,
        'roomVolumeFB': roomVolumeFB,
        // 'roomVolumeCollection': roomVolumeCollection,
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
        sensors: json['sensors'],
        leds: json['leds'],
        current_preset: json['current_preset'],
        presets: json['presets'],
        projectors: json['projectors'],
        servers: json['servers'],
        roomVolumeFB: json['roomVolumeFB'],
        // roomVolumeCollection: json['roomVolumeCollection'],
        roomVolumeId: json['roomVolumeId']);
  }
  // void setRoomVolume() async {
  //   // List<Document> allVolume =
  //   roomVolumeFB = await roomVolumeCollection.orderBy(nameDatabase).get();
  //   final getData = roomVolumeFB.map((volume) {
  //     roomVolumeId = volume.id;
  //     // print('roomVolumeId: ${roomVolumeId.getValue()}');
  //     final checkVolume = volume[nameDatabase].toString();
  //     // print('roomVolume: $checkVolume');
  //     return checkVolume;
  //   });
  //   print('roomVolume: ${getData.first}');
  //   for (Server server in servers) {
  //     server.volume = (double.tryParse(getData.first) ?? 0.0);
  //     // print('roomVolume: ${server.volume.getValue()}');
  //   }
  //   // return check.toString();
  // }
  //
  // updateRoomVolume(double roomVolumeValue) async {
  //   // roomVolumeId = allVolume.id;
  //   await roomVolumeCollection.document(roomVolumeId).update({
  //     // await roomVolumeCollection.document(roomVolumeId!).update({
  //     nameDatabase: roomVolumeValue,
  //     //   'volumeP3' : roomVolumeValue,
  //   });
  // }
}

final Future<Room> default_room = Future.value(Room(
    nameUI: 'Room 1',
    nameDatabase: 'Volume P1',
    power_room_projectors: false,
    shutter_room_projectors: false,
    isSelectedPlay: false,
    isSelectedStop: false,
    map: '',
    general: '',
    resolume: false,
    sensors: [],
    leds: [],
    current_preset: 10,
    presets: [],
    projectors: [],
    servers: [],
    roomVolumeFB: [],
    roomVolumeId: ''));

Future<Room> getRoom(String key) async {
  final SharedPreferences new_prefs = await prefs;
  final String? jsonString = new_prefs.getString(key);
  if (jsonString != null) {
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return Room.fromJson(jsonMap);
  } else {
    return default_room;
  }
}
Future<void> deleteRoom(String key) async {
  final SharedPreferences new_prefs = await prefs;
  await new_prefs.remove(key);
}

Future<void> setNewRoom(Room new_Room, String new_key) async {
  final SharedPreferences new_prefs = await prefs;
  new_prefs.setString(new_key, json.encode(new_Room.toJson()));
}
