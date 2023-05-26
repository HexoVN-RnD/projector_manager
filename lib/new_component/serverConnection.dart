import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_dashboard/Method/ping_check_connection.dart';
import 'package:responsive_dashboard/Method/projector_command.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/pages/checkConnectionBar.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';
import 'package:auto_reload/auto_reload.dart';

class ServerConnection extends StatefulWidget {
  Server server;
  // final VoidCallback onUpdateState;
  ServerConnection({
    required this.server,
    // required this.onUpdateState,
  });

  @override
  State<ServerConnection> createState() => _ServerConnection();
}

class _ServerConnection extends State<ServerConnection> {
  @override
  Widget build(BuildContext context) {
    Server server = widget.server;
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
            server.connected.getValue()
                ? Icons.settings_ethernet
                : Icons.code_off,
            color: server.connected.getValue()
                ? AppColors.navy_blue
                : AppColors.red,
            // widget.projector.connected.getValue() ? Icons.wifi_tethering : Icons.wifi_tethering_off,
            size: 20),
      ),
      title: Row(
        children: [
          Expanded(
            child: PrimaryText(
                text: server.name, size: 15, fontWeight: FontWeight.w700),
          ),
          PrimaryText(
            text: server.ip,
            size: 13,
            fontWeight: FontWeight.w400,
            color: AppColors.secondary,
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: PrimaryText(
            text: server.connected.getValue() ? 'Đã kết nối' : 'Đã mất kết nối',
            size: 13,
            fontWeight: FontWeight.w600),
      ),
      onTap: () {
        setState(() {
          // check_connection(widget.server.ip, widget.server.connected);
          checkConnectionServer(
              server.ip, server.connected, server.power_status);
          // widget.onUpdateState?.call();
        });
        // startAutoReload();
      },
      selected: true,
    );
  }
}
