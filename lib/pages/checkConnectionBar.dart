import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Method/ping_check_connection.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/PopUp/HeroDialogRoute.dart';
import 'package:responsive_dashboard/PopUp/MiniMap.dart';
import 'package:responsive_dashboard/PopUp/PopupZoom.dart';
import 'package:responsive_dashboard/PopUp/customRectTween.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/new_component/sensorConnection.dart';
import 'package:responsive_dashboard/new_component/serverConnection.dart';
import 'package:responsive_dashboard/new_component/projectorConnection.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/pages/roomManager.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

class CheckConnectionBar extends StatefulWidget {
  @override
  State<CheckConnectionBar> createState() => _CheckConnectionBarState();
}

class _CheckConnectionBarState extends State<CheckConnectionBar> {
  @override
  Widget build(BuildContext context) {
    Room room =
        rooms[(current_page.getValue() > 0) ? current_page.getValue() - 1 : 1];
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
          (index) => ServerConnection(
            server: room.servers[index],
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
