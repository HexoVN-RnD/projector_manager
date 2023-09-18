import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Room.dart';
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
  Room room;
  int page;
  MiniMap({
    // required this.roomNotifier,
    required this.room,
    required this.page,
  });

  @override
  State<MiniMap> createState() => _MiniMapState();
}

class _MiniMapState extends State<MiniMap> {
  @override
  Widget build(BuildContext context) {
    Room room = widget.room;
    int page = widget.page;
    double width = Responsive.isDesktop(context)
        ? ((current_page.getValue() != 0)
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
            if (current_page.getValue() == 0)
              Positioned(
                  left: 20,
                  top: 15,
                  child: Material(
                      color: Colors.transparent,
                      child: PrimaryText(text: room.name))),
            if (page == 3)
              Stack(children: [
                Stack(
                  children: List.generate(
                    room.projectors.length,
                        (index) => PositionPage3(
                        projector: room.projectors[index],
                        width: width,
                        height: height),
                  ),
                ),

                Stack(
                  children: List.generate(
                    room.leds.length,
                        (index) => Positioned(
                      left: width * room.leds[index].position.dx,
                      top: height * room.leds[index].position.dy,
                      // left: width * 0.28,
                      // top: height * 0.4,
                      width: width * 0.016,
                      height: width * 0.07,
                      child: Container(
                        decoration: BoxDecoration(
                          color: room.leds[index].connected.getValue()
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
                  room.projectors.length,
                  (index) => PositionPage4(
                      projector: room.projectors[index],
                      width: width,
                      height: height),
                ),
              )
            else if (page == 5)
              Stack(
                children: [
                  Stack(
                    children: List.generate(
                      room.projectors.length,
                      (index) => PositionPage5(
                          projector: room.projectors[index],
                          width: width,
                          height: height),
                    ),
                  ),
                  Stack(
                    children: List.generate(
                      room.sensors.length,
                      (index) => Positioned(
                        // left: width * room.projectors[index].position.dx,
                        // top: height * room.projectors[index].position.dy,
                        left: width * room.sensors[index].position.dx,
                        top: height * room.sensors[index].position.dy,
                        width: width * 0.018,
                        height: width * 0.018,
                        child: Container(
                          decoration: BoxDecoration(
                            color: room.sensors[index].connected.getValue()
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
                    room.projectors.length,
                    (index) => PositionPage6(
                        projector: room.projectors[index],
                        width: width,
                        height: height),
                  ),
                ),
                Positioned(
                  left: width * room.servers[0].position.dx,
                  top: height * room.servers[0].position.dy,
                  // left: width * 0.448,
                  // top: height * 0.45,
                  width: width * 0.1,
                  height: width * 0.1,
                  child: Container(
                    decoration: BoxDecoration(
                        color: room.servers[0].connected.getValue()
                            ? AppColors.green
                            : AppColors.red,
                        borderRadius: BorderRadius.circular(5),
                        border: room.servers[0].isOnHover.getValue()
                            ? Border.all(
                                strokeAlign: BorderSide.strokeAlignCenter,
                                color: room.servers[0].connected.getValue()
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
                    room.servers.length,
                    (index) => PositionPage2(
                        server: room.servers[index],
                        width: width,
                        height: height)),
              ),
          ])),
    );
  }
}
