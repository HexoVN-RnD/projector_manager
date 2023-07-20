import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_dashboard/Method/ping_check_connection.dart';
import 'package:responsive_dashboard/Method/projector_command.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/pages/checkConnectionBar.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';
import 'package:auto_reload/auto_reload.dart';

class ProjectorConnection extends StatefulWidget {
  Projector projector;

  ProjectorConnection({required this.projector});

  @override
  State<ProjectorConnection> createState() => _ProjectorConnectionState();
}

class _ProjectorConnectionState extends State<ProjectorConnection> {
  @override
  Widget build(BuildContext context) {
    Projector projector= widget.projector;
    return MouseRegion(
      onHover: (event){
        setState(() {
          projector.isOnHover.setValue(true);
        });
      },
      onExit: (event) {
        setState(() {
          projector.isOnHover.setValue(false);
        });
      },
      child: ListTile(
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
              projector.connected.getValue()
                  ? Icons.settings_ethernet
                  : Icons.code_off,
              color: projector.connected.getValue()
                  ? AppColors.navy_blue
                  : AppColors.red,
              // projector.connected.getValue() ? Icons.wifi_tethering : Icons.wifi_tethering_off,
              size: 20),
        ),
        title: Row(
          children: [
            Expanded(
              child: PrimaryText(
                  text: projector.name,
                  size: 15,
                  fontWeight: FontWeight.w700),
            ),
            PrimaryText(
              text: projector.ip,
              size: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.secondary,
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: PrimaryText(
              text: projector.connected.getValue()
                  ? 'Đã kết nối'
                  : 'Đã mất kết nối',
              size: 13,
              fontWeight: FontWeight.w600),
        ),
        onTap: () {
          setState(() {
            // projector.connected.setValue(!projector.connected.getValue());
            checkConnectionProjector(projector);
            // final CheckConnectionScene =
            // context.findAncestorStateOfType<CheckConnectionBarState>();
            // if (CheckConnectionScene != null) {
            //   CheckConnectionScene.setState(() {
            //     // Cập nhật trạng thái của widget 1
            //   });
            // }

          });
          // startAutoReload();
        },
        splashColor: AppColors.navy_blue,
        selected: true,
      ),
    );
  }
}
