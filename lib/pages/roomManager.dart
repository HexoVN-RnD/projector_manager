import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:responsive_dashboard/Method/Osc_void.dart';
import 'package:responsive_dashboard/Method/ping_check_connection.dart';
import 'package:responsive_dashboard/Method/projector_command.dart';
import 'package:responsive_dashboard/Method/projector_void.dart';
import 'package:responsive_dashboard/Method/udp_void.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/PopUp/MiniMap.dart';
import 'package:responsive_dashboard/component/barChart.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/new_component/header.dart';
import 'package:responsive_dashboard/new_component/info_projector.dart';
import 'package:responsive_dashboard/new_component/projectorConnection.dart';
import 'package:responsive_dashboard/new_component/sensorConnection.dart';
import 'package:responsive_dashboard/new_component/serverConnection.dart';
import 'package:responsive_dashboard/new_component/volume_edit.dart';
import 'package:responsive_dashboard/pages/appBarActionItems.dart';
import 'package:responsive_dashboard/pages/checkConnectionBar.dart';
import 'package:responsive_dashboard/new_component/info_server.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

class RoomManager extends StatefulWidget {
  @override
  State<RoomManager> createState() => _RoomManagerState();
}

class _RoomManagerState extends State<RoomManager> {
  Timer? _timer;
  Timer? _timer2;

  void select_preset(Room room, int index) async {
    setState(() {
      room.current_preset.setValue(index);
      for (Server server in room.servers) {
        if (room.resolume) {
          SendPresetOSC(
              server.ip, server.preset_port, room.current_preset.getValue());
        } else {
          SendUDPMessage(
              server, 'Preset' + room.current_preset.getValue().toString());
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Đặt một Timer để cập nhật widget sau mỗi giây
    _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      Room room = rooms[
      (current_page.getValue() > 1) ? current_page.getValue() - 1 : 1];
      setState(() {
        if (room.resolume) {
          for (Server server in room.servers) {
            if (server.connected.getValue() &&
                room.current_preset.getValue() <= room.presets.length) {
              OSCReceive(room, server);
            }
          }
        }
      });
    });
    _timer2 = Timer.periodic(Duration(milliseconds: 4000), (timer)
    async {
      Room room = rooms[
      (current_page.getValue() > 1) ? current_page.getValue() - 1 : 1];
      checkRoomConnection(room);
    });
  }

  void dispose() {
    _timer?.cancel();
    _timer2?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Room room =
    rooms[(current_page.getValue() > 0) ? current_page.getValue() - 1 : 0];
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: Container(
                // height: (current_page.getValue() == 1 &&
                //         Responsive.isDesktop(context))
                //     ? SizeConfig.screenHeight
                //     : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Header(
                      room: room,
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 4,
                      child: Row(
                        children: [
                          Icon(
                            Icons.movie_filter,
                            size: 25,
                            color: AppColors.gray,
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeVertical,
                          ),
                          PrimaryText(
                              text: 'Nội dung'.toUpperCase(),
                              size: 20,
                              color: AppColors.gray,
                              fontWeight: FontWeight.w500),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
                      decoration: BoxDecoration(
                        color: AppColors.gray,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children:
                              List.generate(room.presets.length, (index) {
                                bool isSelected =
                                    room.current_preset.getValue() == index;
                                return GestureDetector(
                                  onTap: () {
                                    select_preset(room, index);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AnimatedContainer(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeInOut,
                                        width: isSelected ? 180.0 : 120.0,
                                        height: isSelected ? 180.0 : 120.0,
                                        margin: EdgeInsets.all(20.0),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? AppColors.navy_blue2
                                              : AppColors.white,
                                          borderRadius: BorderRadius.circular(
                                              isSelected ? 20.0 : 15),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                isSelected ? 15.0 : 10),
                                            child: Image.asset(
                                              room.presets[index].image,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          if (isSelected && room.resolume)
                                            SizedBox(
                                              height: 10,
                                              width: 160,
                                              child: Container(
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  child:
                                                  LinearProgressIndicator(
                                                    value: room.presets[index]
                                                        .transport
                                                        .getValue(),
                                                    semanticsLabel:
                                                    'Linear progress indicator',
                                                    color: AppColors.navy_blue2,
                                                    backgroundColor:
                                                    AppColors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          if (isSelected)
                                            SizedBox(
                                                height: SizeConfig
                                                    .blockSizeVertical),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.account_balance,
                                                size: isSelected ? 26 : 15,
                                                color: AppColors.white,
                                              ),
                                              SizedBox(
                                                  width: SizeConfig
                                                      .blockSizeHorizontal *
                                                      (isSelected
                                                          ? 1.5
                                                          : 0.75)),
                                              AnimatedDefaultTextStyle(
                                                style: isSelected
                                                    ? TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 17.0,
                                                    fontWeight:
                                                    FontWeight.w600)
                                                    : TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                    FontWeight.w600),
                                                duration: const Duration(
                                                    milliseconds: 200),
                                                child: Text(
                                                    room.presets[index].name),
                                              ),
                                              // PrimaryText(
                                              //     text: room.presets[index].name,
                                              //     size: isSelected ? 17 : 12,
                                              //     color: AppColors.white,
                                              //     fontWeight: FontWeight.w600),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: List.generate(
                                room.servers.length,
                                    (index) => VolumeEdit(
                                    room: room, server: room.servers[index]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        MiniMap(
                          room: rooms[(current_page.getValue() > 0)
                              ? current_page.getValue() - 1
                              : 1],
                          page: current_page.getValue(),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 15,
                              width: 15,
                              margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              decoration: BoxDecoration(
                                color: AppColors.StatusColor[5],
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: PrimaryText(
                                text: 'Máy chiếu đang bật'.toUpperCase(),
                                size: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal ,
                            ),
                            Container(
                              height: 15,
                              width: 15,
                              margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              decoration: BoxDecoration(
                                color: AppColors.StatusColor[2],
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: PrimaryText(
                                text: 'Máy chiếu đã bật'.toUpperCase(),
                                size: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal ,
                            ),
                            Container(
                              height: 15,
                              width: 15,
                              margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              decoration: BoxDecoration(
                                color: AppColors.StatusColor[3],
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: PrimaryText(
                                text: 'Màn chập đã bật'.toUpperCase(),
                                size: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal ,
                            ),
                            Container(
                              height: 15,
                              width: 15,
                              margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              decoration: BoxDecoration(
                                color: AppColors.StatusColor[1],
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: PrimaryText(
                                text: 'Máy chiếu đã tắt'.toUpperCase(),
                                size: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal ,
                            ),
                            Container(
                              height: 15,
                              width: 15,
                              margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              decoration: BoxDecoration(
                                color: AppColors.StatusColor[0],
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: PrimaryText(
                                text: 'Mất kết nối'.toUpperCase(),
                                size: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 3,
                        ),
                      ],
                    ),
                    //List server
                    if (room.resolume)
                      Column(
                          children: [
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 8,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.airplay,
                                    size: 25,
                                    color: AppColors.gray,
                                  ),
                                  SizedBox(
                                    width: SizeConfig.blockSizeVertical,
                                  ),
                                  PrimaryText(
                                      text: 'Quản lý server'.toUpperCase(),
                                      color: AppColors.gray,
                                      size: 20,
                                      fontWeight: FontWeight.w500),
                                ],
                              ),
                            ),

                            // List Projector
                            SizedBox(
                                width: SizeConfig.screenWidth,
                                child: Wrap(
                                    spacing: 20,
                                    runSpacing: 20,
                                    alignment: WrapAlignment.spaceBetween,
                                    children: List.generate(
                                      room.servers.length,
                                          (index) =>
                                          InfoServer(server: room.servers[index]),
                                    ))
                              // : SpinKitThreeBounce(
                              //     color: AppColors.navy_blue,
                              //     size: 20,
                              //   ),
                            ),

                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 4,
                            ),
                          ]
                      ),
                    if (current_page.getValue() != 0 && current_page.getValue() != 1)
                      Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 8,
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/small_projector.png',
                                  height: 30,
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeVertical,
                                ),
                                PrimaryText(
                                    text: 'Quản lý máy chiếu'.toUpperCase(),
                                    color: AppColors.gray,
                                    size: 20,
                                    fontWeight: FontWeight.w500),
                              ],
                            ),
                          ),
                          SizedBox(
                              width: SizeConfig.screenWidth,
                              child: Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  alignment: WrapAlignment.spaceBetween,
                                  children: List.generate(
                                    room.projectors.length,
                                        (index) => InfoProjector(
                                        projector: room.projectors[index]),
                                  ))
                            // : SpinKitThreeBounce(
                            //     color: AppColors.navy_blue,
                            //     size: 20,
                            //   ),
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 4,
                          ),

                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 4,
                          ),
                        ],
                      ),

                    if (!Responsive.isDesktop(context))
                      CheckConnectionBar(room: room)
                    // else
                    //   Column(
                    //     children: [
                    //       Container(
                    //         alignment: Alignment.centerLeft,
                    //         child: PrimaryText(
                    //           text: room.resolume
                    //               ? 'Kiểm tra tín hiệu server'.toUpperCase()
                    //               : 'Kiểm tra tín hiệu Bright Sign'
                    //                   .toUpperCase(),
                    //           size: 16,
                    //           fontWeight: FontWeight.w500,
                    //           color: AppColors.iconDeepGray,
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: SizeConfig.blockSizeVertical * 2,
                    //       ),
                    //       Wrap(
                    //         children: List.generate(
                    //           room.servers.length,
                    //           (index) => ServerConnection(
                    //             server: room.servers[index],
                    //           ),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: SizeConfig.blockSizeVertical * 2,
                    //       ),
                    //       if (room.sensors.length != 0)
                    //         Column(
                    //           children: [
                    //             Container(
                    //               alignment: Alignment.centerLeft,
                    //               child: PrimaryText(
                    //                 text: 'Kiểm tra tín hiệu cảm biến'
                    //                     .toUpperCase(),
                    //                 size: 16,
                    //                 fontWeight: FontWeight.w500,
                    //                 color: AppColors.iconDeepGray,
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               height: SizeConfig.blockSizeVertical * 2,
                    //             ),
                    //             Column(
                    //               children: List.generate(
                    //                 room.sensors.length,
                    //                 (index) => SensorConnection(
                    //                   sensor: room.sensors[index],
                    //                 ),
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               height: SizeConfig.blockSizeVertical * 2,
                    //             ),
                    //           ],
                    //         ),
                    //       if (room.resolume)
                    //         Container(
                    //           alignment: Alignment.centerLeft,
                    //           child: PrimaryText(
                    //             text:
                    //                 'Kiểm tra tín hiệu máy chiếu'.toUpperCase(),
                    //             size: 16,
                    //             fontWeight: FontWeight.w500,
                    //             color: AppColors.iconDeepGray,
                    //           ),
                    //         ),
                    //       SizedBox(
                    //         height: SizeConfig.blockSizeVertical * 2,
                    //       ),
                    //       Wrap(
                    //         children: List.generate(
                    //           room.projectors.length,
                    //           (index) => ProjectorConnection(
                    //             projector: room.projectors[index],
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                  ],
                ),
              ),
            ),
          ),
          if (Responsive.isDesktop(context) && current_page.getValue() != 0)
            Expanded(
              flex: 1,
              // child: SingleChildScrollView(child: CheckConnectionBar(room: room,)),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.barBg,
                    borderRadius:
                    BorderRadius.horizontal(left: Radius.circular(30))),
                width: double.infinity,
                height: SizeConfig.screenHeight,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: Column(
                    children: [
                      AppBarActionItems(),
                      CheckConnectionBar(
                        room: room,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}