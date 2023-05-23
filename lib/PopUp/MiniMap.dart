import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/PopUp/HeroDialogRoute.dart';
import 'package:responsive_dashboard/PopUp/PopupZoom.dart';
import 'package:responsive_dashboard/PopUp/customRectTween.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

class MiniMap extends StatefulWidget {
  Room room;
  int page;
  MiniMap({
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
            ? (SizeConfig.screenWidth - 200) / 3 - 60
            : SizeConfig.screenWidth / 2 - 150)
        : SizeConfig.screenWidth - 60;
    double height = width * 1050 / 1920;
    return Hero(
      tag: heroZoom,
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
                  left: 20, top: 15, child: PrimaryText(text: room.name)),
            if (page == 2)
              Stack(
                children: List.generate(
                  room.projectors.length,
                  (index) => Positioned(
                    left: width * room.projectors[index].position.dx,
                    top: height * room.projectors[index].position.dy,
                    width: width * 0.0095,
                    height: width * 0.0095,
                    child: Container(
                      color: room.projectors[index].connected.getValue()
                          ? (room.projectors[index].power_status.getValue()
                              ? AppColors.navy_blue
                              : AppColors.red)
                          : AppColors.gray,
                    ),
                  ),
                ),
              )
            else if (page == 3)
              Stack(
                children: List.generate(
                  room.projectors.length,
                  (index) => Positioned(
                    left: width * room.projectors[index].position.dx,
                    top: height * room.projectors[index].position.dy,
                    width: width * 0.018,
                    height: width * 0.018,
                    child: Container(
                      color: room.projectors[index].connected.getValue()
                          ? (room.projectors[index].power_status.getValue()
                              ? AppColors.navy_blue
                              : AppColors.red)
                          : AppColors.gray,
                    ),
                  ),
                ),
              )
            else if (page == 4)
              Stack(
                children: List.generate(
                  room.projectors.length,
                  (index) => Positioned(
                    left: width * room.projectors[index].position.dx,
                    top: height * room.projectors[index].position.dy,
                    width: width * 0.012,
                    height: width * 0.012,
                    child: Container(
                      color: room.projectors[index].connected.getValue()
                          ? (room.projectors[index].power_status.getValue()
                              ? AppColors.navy_blue
                              : AppColors.red)
                          : AppColors.gray,
                    ),
                  ),
                ),
              )
            else if (page == 1)
              Stack(
                children: List.generate(
                  room.servers.length,
                  (index) => Positioned(
                    left: width * room.servers[index].position.dx,
                    top: height * room.servers[index].position.dy,
                    width: width * 0.009,
                    height: height * 0.09,
                    child: Container(
                      color: room.servers[index].connected.getValue()
                          ? AppColors.navy_blue
                          : AppColors.red,
                    ),
                  ),
                ),
              ),
          ])),
    );
  }
}
