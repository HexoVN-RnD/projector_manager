// import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Led.dart';
import 'package:responsive_dashboard/Object/Preset.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Sensor.dart';
import 'package:responsive_dashboard/Object/Server.dart';
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
  List<String> roomVolumeFB;
  dynamic roomVolumeCollection;
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
    required this.roomVolumeCollection,
    required this.roomVolumeId,
  });

  static Future<void> saveVolume(double volume) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('allVolume', volume);
  }

  // Retrieve the volume from local storage
  static Future<double> getAllVolume() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('allVolume') ??
        1.0; // Default value is 1.0 if not found
  }

  void setRoomVolume() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (Server server in servers) {
      server.volume.setValue(prefs.getDouble(server.name) ?? 1.0);
      print('roomVolume: ${server.name} ${server.volume.getValue()}');
    }
    // return check.toString();
  }

  updateRoomVolume(double roomVolumeValue) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setDouble('allVolume', volume);
    for (Server server in servers) {
      prefs.setDouble(server.name, roomVolumeValue);
    }
    // roomVolumeId = allVolume.id;
    // await roomVolumeCollection.document(roomVolumeId.getValue()).update({
    //   // await roomVolumeCollection.document(roomVolumeId!).update({
    //   nameDatabase : roomVolumeValue,
    //   //   'volumeP3' : roomVolumeValue,
    // });
  }
}
