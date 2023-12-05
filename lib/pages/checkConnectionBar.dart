import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Method/ping_check_connection.dart';
import 'package:responsive_dashboard/Object/BrightSign.dart';
import 'package:responsive_dashboard/Object/Led.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/RoomData.dart';
import 'package:responsive_dashboard/Object/Sensor.dart';
import 'package:responsive_dashboard/Object/Server.dart';
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
  RoomData room;
  List<Projector> listProjectors = List.empty(growable: true);
  List<Server> listServers = List.empty(growable: true);
  List<Led> listLeds = List.empty(growable: true);
  List<Sensor> listSensors = List.empty(growable: true);
  List<BrightSign> listBrightSigns = List.empty(growable: true);
  final VoidCallback? onUpdateState;

  CheckConnectionBar({
    Key? key,
    required this.room,
    required this.listProjectors,
    required this.listServers,
    required this.listLeds,
    required this.listSensors,
    required this.listBrightSigns,
    this.onUpdateState,
  }) : super(key: key);

  @override
  State<CheckConnectionBar> createState() => CheckConnectionBarState();
}

class CheckConnectionBarState extends State<CheckConnectionBar> {

  @override
  Widget build(BuildContext context) {
    // RoomData room = widget.room;
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
                text: widget.room.nameUI,
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

      if (widget.listServers!.length != 0)
      Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: PrimaryText(
              text: 'Kiểm tra tín hiệu server'.toUpperCase(),
              size: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.iconDeepGrey,
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          Column(
            children: List.generate(
              widget.listServers!.length,
                  (index) =>  ServerConnection(server: widget.listServers![index],),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
        ],
      ),
      if (widget.listSensors.isNotEmpty)
        Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: PrimaryText(
                text: 'Kiểm tra tín hiệu cảm biến'.toUpperCase(),
                size: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.iconDeepGrey,
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Column(
              children: List.generate(
                widget.listSensors!.length,
                (index) => SensorConnection(
                  sensor: widget.listSensors![index],
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
          ],
        ),
      if (widget.listLeds.isNotEmpty)
        Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: PrimaryText(
                text: 'Kiểm tra tín hiệu màn led'.toUpperCase(),
                size: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.iconDeepGrey,
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Column(
              children: List.generate(
                widget.listLeds.length,
                (index) => LedConnection(
                  led: widget.listLeds[index],
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
          ],
        ),
      if (widget.listProjectors.isNotEmpty)
        Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryText(
            text: 'Kiểm tra tín hiệu máy chiếu'.toUpperCase(),
            size: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.iconDeepGrey,
          ),
        ],
      ),
      SizedBox(
        height: SizeConfig.blockSizeVertical * 2,
      ),
      Column(
        children: List.generate(
          widget.listProjectors.length,
          (index) => ProjectorConnection(
            projector: widget.listProjectors[index],
          ),
        ),
      ),
    ]);
  }
}
