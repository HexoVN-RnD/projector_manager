import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/BrightSign.dart';
import 'package:responsive_dashboard/Object/Led.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/RoomData.dart';
import 'package:responsive_dashboard/Object/Sensor.dart';
import 'package:responsive_dashboard/PopUp/HeroDialogRoute.dart';
import 'package:responsive_dashboard/PopUp/PopupZoom.dart';
import 'package:responsive_dashboard/PopUp/PositionPage2.dart';
import 'package:responsive_dashboard/PopUp/PositionPage3.dart';
import 'package:responsive_dashboard/PopUp/PositionPage4.dart';
import 'package:responsive_dashboard/PopUp/PositionPage5.dart';
import 'package:responsive_dashboard/PopUp/PositionPage6.dart';
import 'package:responsive_dashboard/PopUp/customRectTween.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

class MiniMap extends StatefulWidget {
  // final ValueNotifier<Room> roomNotifier;
  RoomData room;
  List<Projector> listProjectors = List.empty(growable: true);
  List<Led> listLeds = List.empty(growable: true);
  List<Sensor> listSensors = List.empty(growable: true);
  List<BrightSign> listBrightSigns = List.empty(growable: true);
  int page;
  MiniMap({
    required this.listProjectors,
    required this.listLeds,
    required this.listSensors,
    required this.listBrightSigns,
    required this.room,
    required this.page,
  });

  @override
  State<MiniMap> createState() => _MiniMapState();
}

class _MiniMapState extends State<MiniMap> {
  @override
  Widget build(BuildContext context) {
    RoomData room = widget.room;
    int page = widget.page;
    double width = Responsive.isDesktop(context)
        ? ((current_page != 0)
            ? (SizeConfig.screenWidth - 200) / 3 * 2 - 60
            : SizeConfig.screenWidth / 2 - 150)
        : SizeConfig.screenWidth - 60;
    double height = width * 1050 / 1920;
    return Hero(
      tag: (page == 1)
          ? heroZoom1
          : ((page == 2)
              ? heroZoom2
              : (page == 3)
                  ? heroZoom3
                  : (page == 4)
                      ? heroZoom4
                      : (page == 5)
                          ? heroZoom5
                          : heroZoom6),
      createRectTween: (begin, end) {
        return CustomRectTween(begin: begin, end: end);
      },
      child: Container(
          // constraints: BoxConstraints.expand(),
          margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
          height: height,
          width: width,
          // decoration: BoxDecoration(
          //   // color: AppColors.gray,
          //   borderRadius: BorderRadius.circular(15),
          // ),
          child: Stack(alignment: Alignment.topRight, children: [
            Positioned(
              width: width,
              height: height,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  room.map,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white_trans,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                setState(() {
                  Navigator.of(context)
                      .push(HeroDialogRoute(builder: (context) {
                    return PopupZoom(
                      room: room,
                      page: page,
                      listProjectors: widget.listProjectors,
                      listLeds: widget.listLeds,
                      listSensors: widget.listSensors,
                      listBrightSigns: widget.listBrightSigns,
                    );
                  }));
                  // PowerAllServers(false);
                });
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: Icon(
                  Icons.zoom_in,
                  size: 25,
                  color: AppColors.white,
                ),
              ),
            ),
            if (current_page == 0)
              Positioned(
                  left: 20,
                  top: 15,
                  child: Material(
                      color: Colors.transparent,
                      child: PrimaryText(text: room.nameUI))),
            if (page == 3)
              Stack(children: [
                Stack(
                  children: List.generate(
                    widget.listProjectors.length,
                    (index) => PositionPage3(
                        projector: widget.listProjectors[index],
                        width: width,
                        height: height),
                  ),
                ),
                Stack(
                  children: List.generate(
                    widget.listLeds.length,
                    (index) => Positioned(
                      left: width * widget.listLeds[index].position_x,
                      top: height * widget.listLeds[index].position_y,
                      // left: width * 0.28,
                      // top: height * 0.4,
                      width: width * 0.016,
                      height: width * 0.07,
                      child: Container(
                        decoration: BoxDecoration(
                          color: widget.listLeds[index].connected
                              ? AppColors.green
                              : AppColors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
              ])
            else if (page == 4)
              Stack(
                children: List.generate(
                  widget.listProjectors.length,
                  (index) => PositionPage4(
                      projector: widget.listProjectors[index],
                      width: width,
                      height: height),
                ),
              )
            else if (page == 5)
              Stack(
                children: [
                  Stack(
                    children: List.generate(
                      widget.listProjectors.length,
                      (index) => PositionPage5(
                          projector: widget.listProjectors[index],
                          width: width,
                          height: height),
                    ),
                  ),
                  Stack(
                    children: List.generate(
                      widget.listSensors.length,
                      (index) => Positioned(
                        // left: width * widget.listProjectors[index].position_x,
                        // top: height * widget.listProjectors[index].position_y,
                        left: width * widget.listSensors[index].position_x,
                        top: height * widget.listSensors[index].position_y,
                        width: width * 0.018,
                        height: width * 0.018,
                        child: Container(
                          decoration: BoxDecoration(
                            color: widget.listSensors[index].connected
                                ? AppColors.green
                                : AppColors.red,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            else if (page == 6)
              Stack(children: [
                Stack(
                  children: List.generate(
                    widget.listProjectors.length,
                    (index) => PositionPage6(
                        projector: widget.listProjectors[index],
                        width: width,
                        height: height),
                  ),
                ),
                Positioned(
                  left: width * widget.listBrightSigns[0].position_x,
                  top: height * widget.listBrightSigns[0].position_y,
                  // left: width * 0.448,
                  // top: height * 0.45,
                  width: width * 0.1,
                  height: width * 0.1,
                  child: Container(
                    decoration: BoxDecoration(
                        color: widget.listBrightSigns[0].connected
                            ? AppColors.green
                            : AppColors.red,
                        borderRadius: BorderRadius.circular(5),
                        border: widget.listBrightSigns[0].isOnHover
                            ? Border.all(
                                strokeAlign: BorderSide.strokeAlignCenter,
                                color: widget.listBrightSigns[0].connected
                                    ? AppColors.green
                                    : AppColors.red,
                                width: 10.0,
                              )
                            : Border.all(
                                color: Colors.transparent,
                                width: 10.0,
                              )),
                  ),
                ),
              ])
            else if (page == 2)
              Stack(
                children: List.generate(
                    widget.listBrightSigns.length,
                    (index) => PositionPage2(
                        brightSign: widget.listBrightSigns[index],
                        width: width,
                        height: height)),
              ),
          ])),
    );
  }
}
