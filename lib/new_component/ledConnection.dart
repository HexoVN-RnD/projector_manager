import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Method/ping_check_connection.dart';
import 'package:responsive_dashboard/Object/Led.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

class LedConnection extends StatefulWidget {
  Led led;

  LedConnection({required this.led});

  @override
  State<LedConnection> createState() => _LedConnectionState();
}

class _LedConnectionState extends State<LedConnection> {
  @override
  Widget build(BuildContext context) {
    Led led = widget.led;
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
            led.connected.getValue() ? Icons.settings_ethernet : Icons.code_off,
            color:
                led.connected.getValue() ? AppColors.navy_blue : AppColors.red,
            // projector.connected.getValue() ? Icons.wifi_tethering : Icons.wifi_tethering_off,
            size: 20),
      ),
      title: Row(
        children: [
          Expanded(
            child: PrimaryText(
                text: led.name, size: 15, fontWeight: FontWeight.w700),
          ),
          PrimaryText(
            text: led.ip,
            size: 13,
            fontWeight: FontWeight.w400,
            color: AppColors.secondary,
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: PrimaryText(
            text: led.connected.getValue() ? 'Đã kết nối' : 'Đã mất kết nối',
            size: 13,
            fontWeight: FontWeight.w600),
      ),
      onTap: () {
        setState(() {
          checkConnectionLed(led);
        });
        // startAutoReload();
      },
      selected: true,
    );
  }
}
