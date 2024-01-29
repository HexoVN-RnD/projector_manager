import 'package:responsive_dashboard/data/data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valuable/valuable.dart';

import '../Object/Preset.dart';

Future<void> LoadData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  for (int i = 0; i < rooms[0].presets.length; i++) {
    rooms[0].presets[i].name = prefs.getString('presets_name_$i') ?? rooms[0].presets[i].name;
    // print(rooms[0].presets[i].name);
  }
  // print(prefs.getString('all_volume')?? '0.0');
  allRoom.allVolumeFB = double.parse(prefs.getString('all_volume')?? '0.0') ;
  rooms[0].servers[0].volume.setValue(double.parse(prefs.getString('all_volume')?? '0.0')) ;
}

Future<void> SaveData(String address, String text) async {
  print('Save');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(address, text);
}
