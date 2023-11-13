import 'package:responsive_dashboard/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> getAllDatabyKey(String keyword) async {
  final SharedPreferences new_prefs = await prefs;
  List<String> Keys = [];
  Map<String, dynamic> allData = {};

  Keys = new_prefs.getKeys().where((key) => key.startsWith(keyword)).toList();
  for (var key in Keys) {
    allData[key] = new_prefs.get(key);
  }
  return allData;
  // print('Projector keys: $projectorKeys');
}
Future<void> deleteAllData() async {
  SharedPreferences new_prefs = await prefs;
  new_prefs.clear();
}


bool isIP(String value) {
  // Regular expression for IPv4
  final RegExp ipv4Regex =
  RegExp(r'^(\d{1,3}\.){3}\d{1,3}$');

  // Regular expression for IPv6
  final RegExp ipv6Regex =
  RegExp(r'^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$');

  // Check if the value matches either IPv4 or IPv6 regex
  return ipv4Regex.hasMatch(value) || ipv6Regex.hasMatch(value);
}