import 'dart:async';

import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/BrightSign.dart';
import 'package:responsive_dashboard/Object/Led.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/RoomData.dart';
import 'package:responsive_dashboard/Object/Sensor.dart';
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
const String heroZoom5 = 'popup-zoom5';
const String heroZoom6 = 'popup-zoom6';

/// {@template add_todo_popup_card}
/// Popup card to add a new [Todo]. Should be used in conjuction with
/// [HeroDialogRoute] to achieve the popup effect.
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class PopupZoom extends StatefulWidget {
  /// {@macro add_todo_popup_card}
  RoomData room;
  List<Projector> listProjectors = List.empty(growable: true);
  List<Led> listLeds = List.empty(growable: true);
  List<Sensor> listSensors = List.empty(growable: true);
  List<BrightSign> listBrightSigns = List.empty(growable: true);
  int page;
  PopupZoom({
    required this.listProjectors,
    required this.listLeds,
    required this.listSensors,
    required this.listBrightSigns,
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
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // RoomData room = widget.room;
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
                    : (page == 4)
                        ? heroZoom4
                        : (page == 5)
                            ? heroZoom5
                            : heroZoom6),
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
                    widget.room.map,
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
              if (page == 3)
                Stack(
                  children: [
                    Stack(
                      children: List.generate(
                        widget.listProjectors.length,
                            (index) => Positioned(
                          left: width * widget.listProjectors[index].position_x,
                          top: height * widget.listProjectors[index].position_y,
                          // left: width * 0.445,
                          // top: height * 0.49,
                          width: width * 0.018,
                          height: width * 0.018,
                          child: Container(
                            color: AppColors.StatusColor[
                            widget.listProjectors[index].status],
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      children: List.generate(
                        widget.listLeds.length,
                            (index) => Positioned(
                          left: width * widget.listLeds[index].position_x,
                          top: height * widget.listLeds[index].position_y,
                          // left: width * 0.725,
                          // top: height * 0.125,
                          width: width * 0.016,
                          height: width * 0.07,
                          child: Container(
                            decoration: BoxDecoration(
                              color: widget.listLeds[index].connected
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
                  children: List.generate(
                    widget.listProjectors.length,
                    (index) => Positioned(
                      left: width * widget.listProjectors[index].position_x,
                      top: height * widget.listProjectors[index].position_y,
                      width: width * 0.0095,
                      height: width * 0.0095,
                      child: Container(
                        color: AppColors.StatusColor[
                            widget.listProjectors[index].status],
                      ),
                    ),
                  ),
                )
              else if (page == 5)
                Stack(
                  children: [
                    Stack(
                      children: List.generate(
                        widget.listProjectors.length,
                        (index) => Positioned(
                          left: width * widget.listProjectors[index].position_x,
                          top: height * widget.listProjectors[index].position_y,
                          width: width * 0.018,
                          height: width * 0.018,
                          child: Container(
                            color: AppColors.StatusColor[
                                widget.listProjectors[index].status],
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      children: List.generate(
                        widget.listSensors.length,
                        (index) => Positioned(
                          left: width * widget.listSensors[index].position_x,
                          top: height * widget.listSensors[index].position_y,
                          // left: width * 0.555,
                          // top: height * 0.858,
                          width: width * 0.016,
                          height: width * 0.016,
                          child: Container(
                            decoration: BoxDecoration(
                              color: widget.listSensors[index].connected
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
              else if (page == 6)
                Stack(
                  children: [
                    Stack(
                      children: List.generate(
                        widget.listProjectors.length,
                        (index) => Positioned(
                          left: width * widget.listProjectors[index].position_x,
                          top: height * widget.listProjectors[index].position_y,
                          width: width * 0.012,
                          height: width * 0.012,
                          child: Container(
                            color: AppColors.StatusColor[
                                widget.listProjectors[index].status],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: width * widget.listBrightSigns![0].position_x,
                      top: height * widget.listBrightSigns![0].position_y,
                      // left: width * 0.448,
                      // top: height * 0.45,
                      width: width * 0.1,
                      height: width * 0.1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: widget.listBrightSigns![0].connected
                                ? AppColors.green
                                : AppColors.red,
                            borderRadius: BorderRadius.circular(5),
                            border: widget.listBrightSigns![0].isOnHover
                                ? Border.all(
                                    strokeAlign: BorderSide.strokeAlignCenter,
                                    color: widget.listBrightSigns![0].connected
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
                  ],
                )
              else if (page == 2)
                Stack(
                  children: List.generate(
                    widget.listBrightSigns!.length,
                    (index) => Positioned(
                      left: width * widget.listBrightSigns![index].position_x,
                      top: height * widget.listBrightSigns![index].position_y,
                      width: width * 0.009,
                      height: height * 0.09,
                      child: Container(
                        color: widget.listBrightSigns![index].connected
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
