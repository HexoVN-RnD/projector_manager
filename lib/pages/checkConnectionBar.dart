import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Method/ping_check_connection.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/PopUp/MiniMap.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/new_component/sensorConnection.dart';
import 'package:responsive_dashboard/new_component/serverConnection.dart';
import 'package:responsive_dashboard/new_component/projectorConnection.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

class CheckConnectionBar extends StatefulWidget {
  Room room;
  final VoidCallback? onUpdateState;

  CheckConnectionBar({
    Key? key,
    required this.room,
    this.onUpdateState,
  }) : super(key: key);

  @override
  State<CheckConnectionBar> createState() => CheckConnectionBarState();
}

class CheckConnectionBarState extends State<CheckConnectionBar> {

  @override
  Widget build(BuildContext context) {
    Room room = widget.room;
    double width = Responsive.isDesktop(context)
        ? (MediaQuery.of(context).size.width-200) / 3
        : MediaQuery.of(context).size.width - 40;
    double height = width*1050/1920;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: SizeConfig.blockSizeVertical * 3,
      ),
      Row(
        children: [
          Expanded(
            child: PrimaryText(
                text: rooms[(current_page.getValue() > 0)
                        ? current_page.getValue() - 1
                        : 1]
                    .name,
                size: 18,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 40,
            width: 110,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.navy_blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                setState(() {
                  checkAllConnection(room);
                });
              },
              child: PrimaryText(
                text: 'Kiểm tra',
                size: 14,
                // color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
      MiniMap(room: rooms[(current_page.getValue()>0)? current_page.getValue()-1:1], page: current_page.getValue(),),
      PrimaryText(
        text: room.resolume? 'Kiểm tra tín hiệu server': 'Kiểm tra tín hiệu Bright Sign',
        size: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.iconDeepGray,
      ),
      SizedBox(
        height: SizeConfig.blockSizeVertical * 2,
      ),
      Column(
        children: List.generate(
          room.servers.length,
              (index) =>  ServerConnection(server: room.servers[index], onUpdateState: () {  },),
        ),
      ),
      Column(
        children: List.generate(
          room.servers.length,
          (index) =>  ListTile(
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
                  room.servers[index].connected.getValue()
                      ? Icons.settings_ethernet
                      : Icons.code_off,
                  color: room.servers[index].connected.getValue()
                      ? AppColors.navy_blue
                      : AppColors.red,
                  // widget.projector.connected.getValue() ? Icons.wifi_tethering : Icons.wifi_tethering_off,
                  size: 20),
            ),
            title: Row(
              children: [
                Expanded(
                  child: PrimaryText(
                      text: room.servers[index].name, size: 15, fontWeight: FontWeight.w700),
                ),
                PrimaryText(
                  text: room.servers[index].ip,
                  size: 13,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondary,
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: PrimaryText(
                  text: room.servers[index].connected.getValue() ? 'Đã kết nối' : 'Đã mất kết nối',
                  size: 13,
                  fontWeight: FontWeight.w600),
            ),
            onTap: () {
              setState(() {
                // check_connection(widget.server.ip, widget.server.connected);
                checkConnectionServer(
                    room.servers[index].ip, room.servers[index].connected, room.servers[index].power_status);
                widget.onUpdateState?.call();
              });
              // startAutoReload();
            },
            selected: true,
          ),
        ),
      ),
      SizedBox(
        height: SizeConfig.blockSizeVertical * 2,
      ),
      if (room.sensors.length != 0)
        Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: PrimaryText(
                text: 'Kiểm tra tín hiệu cảm biến',
                size: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.iconDeepGray,
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Column(
              children: List.generate(
                room.sensors.length,
                (index) => SensorConnection(
                  sensor: room.sensors[index],
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
          ],
        ),
      if (room.resolume) Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryText(
            text: 'Kiểm tra tín hiệu máy chiếu',
            size: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.iconDeepGray,
          ),
        ],
      ),
      SizedBox(
        height: SizeConfig.blockSizeVertical * 2,
      ),
      Column(
        children: List.generate(
          room.projectors.length,
          (index) => ProjectorConnection(
            projector: room.projectors[index],
          ),
        ),
      ),
    ]);
  }
}
