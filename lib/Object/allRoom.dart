import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Preset.dart';
import 'package:firedart/firedart.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:valuable/valuable.dart';

class AllRoom {
  bool canRun;
  bool power_all_projectors;
  bool shutter_all_projectors;
  bool power_all_servers;
  bool is_switch_colume;
  double volume_all;
  int current_preset;
  int current_colume;
  double current_transport;
  int num_servers_connected;
  int num_projectors_connected;
  int num_servers;
  int num_sensors;
  int num_leds;
  int num_projectors;
  List<Preset> presets;
  List<Document> allVolumeFB;
  CollectionReference volumeCollection;
  String volumeId;
  // : 1,2,3
  // List<Projector> projectors;
  // List<Server> servers;

  // Constructor
  AllRoom({
    required this.canRun,
    required this.power_all_projectors,
    required this.shutter_all_projectors,
    required this.power_all_servers,
    required this.is_switch_colume,
    required this.volume_all,
    required this.current_preset,
    required this.current_colume,
    required this.current_transport,
    required this.presets,
    required this.num_servers_connected,
    required this.num_projectors_connected,
    required this.num_servers,
    required this.num_sensors,
    required this.num_leds,
    required this.num_projectors,
    required this.allVolumeFB,
    required this.volumeCollection,
    required this.volumeId,
  });
  void setLicenseStatus() async {
    CollectionReference licenseStatusCollection =
        Firestore.instance.collection('license_status');
    List<Document> license_status = [];
    license_status = await licenseStatusCollection.orderBy('run').get();
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        allRoom.canRun = license_status.any((status) {
          final license_status = status['run'].toString();
          return license_status == 'true';
        });
      },
    );
    print('setLicenseStatus');
  }

  void setAllVolume() async {
    // List<Document> allVolume =
    allVolumeFB = await volumeCollection.orderBy('allVolume').get();
    final check = allVolumeFB.map((volume) {
      volumeId = (volume.id);
      // print('volumeId: ${volumeId}');
      final checkVolume = volume['allVolume'].toString();
      // print('allVolume: $checkVolume');
      volume_all = double.tryParse(checkVolume.toString()) ?? 0.0;
      return [volumeId, checkVolume];
    });
    print('allVolume: ${check}');
  }

  void updateAllVolume(double allVolumeValue) async {
    // volumeId = allVolume.id;
    // print('ENLH4hL9FNkV87USu2Iv');
    await volumeCollection.document(volumeId).update({
      // await volumeCollection.document(volumeId!).update({
      'allVolume': allVolumeValue,
    });
    for (Room room in rooms) {
      await room.roomVolumeCollection.document(volumeId).update({
        // await roomVolumeCollection.document(roomVolumeId!).update({
        room.nameDatabase: allVolumeValue,
        //   'volumeP3' : roomVolumeValue,
      });
    }
  }
}
