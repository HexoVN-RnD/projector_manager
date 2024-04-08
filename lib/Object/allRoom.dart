import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Preset.dart';
// import 'package:firedart/firedart.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valuable/valuable.dart';

class AllRoom {
  StatefulValuable<bool> canRun;
  StatefulValuable<bool> power_all_projectors;
  StatefulValuable<bool> shutter_all_projectors;
  StatefulValuable<bool> power_all_servers;
  StatefulValuable<bool> is_switch_colume;
  StatefulValuable<double> volume_all;
  StatefulValuable<int> current_preset;
  StatefulValuable<int> current_colume;
  StatefulValuable<double> current_transport;
  StatefulValuable<int> num_servers_connected;
  StatefulValuable<int> num_projectors_connected;
  StatefulValuable<int> num_servers;
  StatefulValuable<int> num_sensors;
  StatefulValuable<int> num_leds;
  StatefulValuable<int> num_projectors;
  List<Preset> presets;
  List<String> allVolumeFB;
  dynamic volumeCollection;
  StatefulValuable<String> volumeId;
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
  // Save the volume locally
  static Future<void> saveVolume(double volume) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('allVolume', volume);
  }

  // Retrieve the volume from local storage
  static Future<double> getAllVolume() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('allVolume') ?? 1.0; // Default value is 1.0 if not found
  }
  // void setLicenseStatus() async {
  //   // CollectionReference licenseStatusCollection =
  //   //     Firestore.instance.collection('license_status');
  //   // List<Document> license_status = [];
  //   license_status = await licenseStatusCollection.orderBy('run').get();
  //   Future.delayed(
  //     const Duration(milliseconds: 500),
  //     () {
  //       allRoom.canRun.setValue(license_status.any((status) {
  //         final license_status = status['run'].toString();
  //         return license_status == 'true';
  //       }));
  //     },
  //   );
  //   print('setLicenseStatus');
  // }

  void setAllVolume() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double volume = prefs.getDouble('allVolume') ?? 1.0;
    volume_all.setValue(volume);
    print('allVolume: ${volume}');
  }

  void updateAllVolume(double allVolumeValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('allVolume', allVolumeValue);
    for (Room room in rooms) {
      room.updateRoomVolume(allVolumeValue);
    }
  }
}
