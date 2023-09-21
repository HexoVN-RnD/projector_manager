import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Led.dart';
import 'package:responsive_dashboard/Object/Preset.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Sensor.dart';
import 'package:responsive_dashboard/Object/Server.dart';
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
  List<Document> roomVolumeFB;
  CollectionReference roomVolumeCollection;
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

  void setRoomVolume() async {
    // List<Document> allVolume =
    roomVolumeFB = await roomVolumeCollection.orderBy(nameDatabase).get();
    final getData =  roomVolumeFB.map((volume) {
      roomVolumeId.setValue(volume.id);
      // print('roomVolumeId: ${roomVolumeId.getValue()}');
      final checkVolume = volume[nameDatabase].toString();
      // print('roomVolume: $checkVolume');
      return checkVolume;
    });
    print('roomVolume: ${getData.first}');
    for (Server server in servers) {
      server.volume
          .setValue((double.tryParse(getData.first) ?? 0.0));
      // print('roomVolume: ${server.volume.getValue()}');
    }
    // return check.toString();
  }

  updateRoomVolume(double roomVolumeValue) async {
    // roomVolumeId = allVolume.id;
    await roomVolumeCollection.document(roomVolumeId.getValue()).update({
      // await roomVolumeCollection.document(roomVolumeId!).update({
      nameDatabase : roomVolumeValue,
      //   'volumeP3' : roomVolumeValue,
    });
  }
}
