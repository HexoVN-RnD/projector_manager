import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_dashboard/Method/ping_check_connection.dart';
import 'package:responsive_dashboard/Method/projector_command.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Sensor.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';
import 'package:auto_reload/auto_reload.dart';

class SensorConnection extends StatefulWidget {
  Sensor sensor;

  SensorConnection({required this.sensor});

  @override
  State<SensorConnection> createState() => _SensorConnectionState();
}

class _SensorConnectionState extends State<SensorConnection> {
  @override
  Widget build(BuildContext context) {
    Sensor sensor=widget.sensor;
    return ListTile(
      contentPadding: EdgeInsets.only(left: 0, right: 20),
      visualDensity: VisualDensity.standard,
      leading: Container(
        width: 50,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
            sensor.connected ? Icons.settings_ethernet : Icons.code_off,
            color: sensor.connected ? AppColors.navy_blue: AppColors.red,
            // projector.connected ? Icons.wifi_tethering : Icons.wifi_tethering_off,
            size: 20),
      ),
      title: Row(
        children: [
          Expanded(
            child: PrimaryText(
                text: sensor.name, size: 15, fontWeight: FontWeight.w700),
          ),

          PrimaryText(
            text: sensor.ip,
            size: 13,
            fontWeight: FontWeight.w400,
            color: AppColors.secondary,
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: PrimaryText(
            text: sensor.connected? 'Đã kết nối' : 'Đã mất kết nối',
            size: 13,
            fontWeight: FontWeight.w600),
      ),
      onTap: () {
        setState(() {
          checkConnectionSensor(sensor);
        });
        // startAutoReload();
      },
      selected: true,
    );
  }
}
