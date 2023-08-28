import 'dart:async';

import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/PopUp/customRectTween.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/style/colors.dart';

const String heroZoom1 = 'popup-zoom1';
const String heroZoom2 = 'popup-zoom2';
const String heroZoom3 = 'popup-zoom3';
const String heroZoom4 = 'popup-zoom4';

/// {@template add_todo_popup_card}
/// Popup card to add a new [Todo]. Should be used in conjuction with
/// [HeroDialogRoute] to achieve the popup effect.
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class PopupZoom extends StatefulWidget {
  /// {@macro add_todo_popup_card}
  Room room;
  int page;
  PopupZoom({
    required this.room,
    required this.page,
  });

  @override
  State<PopupZoom> createState() => _PopupZoomState();
}

class _PopupZoomState extends State<PopupZoom> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) async {
      setState(() {
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Room room = widget.room;
    int page = widget.page;
    final width = Responsive.isDesktop(context)
        ? SizeConfig.screenWidth - 200
        : SizeConfig.screenWidth - 60;
    final height = width * 1050 / 1920;
    return Center(
      child: Hero(
        tag: (page == 1)
            ? heroZoom1
            : ((page == 2)
                ? heroZoom2
                : (page == 3)
                    ? heroZoom3
                    : heroZoom4),
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin, end: end);
        },
        child: SingleChildScrollView(
          child: Container(
            width: width,
            height: height,
            // decoration: BoxDecoration(
            //     color: AppColors.gray,
            //     borderRadius: BorderRadius.circular(30)),
            child: Stack(alignment: Alignment.topRight, children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    room.map,
                    fit: BoxFit.fill,
                  )),
              Padding(
                // padding: EdgeInsets.only(left: width-10,bottom: height-10),
                padding:
                    EdgeInsets.only(left: width - 100, bottom: height - 100),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white_trans,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      // print('check');
                      Navigator.of(context).pop();
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: Icon(
                      Icons.zoom_out,
                      size: 25,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
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
                        color: AppColors.StatusColor[room.projectors[index].status.getValue()],
                      ),
                    ),
                  ),
                )
              else if (page == 3)
                Stack(
                  children: [
                    Stack(
                      children: List.generate(
                        room.projectors.length,
                        (index) => Positioned(
                          left: width * room.projectors[index].position.dx,
                          top: height * room.projectors[index].position.dy,
                          width: width * 0.018,
                          height: width * 0.018,
                          child: Container(
                            color:  AppColors.StatusColor[room.projectors[index].status.getValue()],
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      children: List.generate(
                        room.sensors.length,
                            (index) => Positioned(
                          left: width * room.sensors[index].position.dx,
                          top: height * room.sensors[index].position.dy,
                          // left: width * 0.555,
                          // top: height * 0.858,
                          width: width * 0.016,
                          height: width * 0.016,
                          child: Container(
                            decoration: BoxDecoration(
                              color: room.sensors[index].connected.getValue()
                                  ? AppColors.green
                                  : AppColors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              else if (page == 4)
                Stack(
                  children: [
                    Stack(
                      children: List.generate(
                        room.projectors.length,
                        (index) => Positioned(
                          left: width * room.projectors[index].position.dx,
                          top: height * room.projectors[index].position.dy,
                          width: width * 0.012,
                          height: width * 0.012,
                          child: Container(
                            color: AppColors.StatusColor[room.projectors[index].status.getValue()],
                          ),
                        ),
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
                            color: room.servers[0].connected.getValue()? AppColors.green: AppColors.red,
                            borderRadius: BorderRadius.circular(5),
                            border: room.servers[0].isOnHover.getValue()
                                ? Border.all(
                              strokeAlign: BorderSide.strokeAlignCenter,
                              color: room.servers[0].connected.getValue()? AppColors.green: AppColors.red,
                              width: 10.0,
                            )
                                : Border.all(
                              color: Colors.transparent,
                              width: 10.0,
                            )),
                      ),
                    ),
                  ],
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
                            ? AppColors.green
                            : AppColors.red,
                      ),
                    ),
                  ),
                ),
            ]),
          ),
        ),
      ),
    );
  }
}
