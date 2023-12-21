import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Method/ping_check_connection.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/PopUp/MiniMap.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/new_component/ledConnection.dart';
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
                text: 'Kiểm tra tín hiệu',
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
                  checkFullConnection(4000);
                  widget.onUpdateState?.call();
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
      SizedBox(
        height: SizeConfig.blockSizeVertical * 3,
      ),
      PrimaryText(
        text: room.resolume? 'Kiểm tra tín hiệu server'.toUpperCase(): 'Kiểm tra tín hiệu Bright Sign'.toUpperCase(),
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
              (index) =>  ServerConnection(room: room,server: room.servers[index],),
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
                text: 'Kiểm tra tín hiệu cảm biến'.toUpperCase(),
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
      if (room.leds.length != 0)
        Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: PrimaryText(
                text: 'Kiểm tra tín hiệu màn led'.toUpperCase(),
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
                room.leds.length,
                (index) => LedConnection(
                  led: room.leds[index],
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
          ],
        ),
      if (room.projectors.length != 0 || current_page.getValue()==4) Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryText(
            text: 'Kiểm tra tín hiệu máy chiếu'.toUpperCase(),
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
