import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:responsive_dashboard/Method/Control_all_projectors_void.dart';
import 'package:responsive_dashboard/Method/Osc_void.dart';
import 'package:responsive_dashboard/Method/ping_check_connection.dart';
import 'package:responsive_dashboard/Method/projector_command.dart';
import 'package:responsive_dashboard/Method/projector_void.dart';
import 'package:responsive_dashboard/Method/udp_void.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/RoomData.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/PopUp/HeroDialogRoute.dart';
import 'package:responsive_dashboard/PopUp/MiniMap.dart';
import 'package:responsive_dashboard/PopUp/PopupAddProjetor.dart';
import 'package:responsive_dashboard/PopUp/PopupAddProjetor_new.dart';
import 'package:responsive_dashboard/PopUp/PopupOffProjector.dart';
import 'package:responsive_dashboard/PopUp/PopupOffShutter.dart';
import 'package:responsive_dashboard/PopUp/customRectTween.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/Shared_Prefs_Method.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/new_component/header.dart';
import 'package:responsive_dashboard/new_component/info_projector.dart';
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
  bool isSelectedPlay = false;
  bool isSelectedStop = false;
  int oldPage = 0;
  late Future<RoomData> roomdata;
  late Future<List<Projector>> listProjector;
  late Room room;

  void select_preset(Room room, int index) async {
    setState(() {
      room.current_preset = (index);
      for (Server server in room.servers!) {
        if (room.resolume) {
          SendPresetOSC(server.ip, server.preset_port, room.current_preset);
          PlayPreset(current_page);
        } else {
          SendUDPMessage(
              server, 'Preset' + (room.current_preset + 1).toString());
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Đặt một Timer để cập nhật widget sau mỗi giây
    // _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
    //   // Room room = rooms[
    //   //     (current_page > 1) ? current_page - 1 : 1];
    //   setState(() {
    //     // if (current_page == 4) {
    //     //   // for (Server server in room.servers!) {
    //     //   if (room.servers![0].connected) {
    //     //     OSCReceive();
    //     //   }
    //     //   // }
    //     // } else if (current_page == 3) {
    //     //   // for (Server server in room.servers!) {
    //     //   if (room.servers![0].connected) {
    //     //     OSCReceive();
    //     //   }
    //     //   // }
    //     // }
    //   });
    // });
    // _timer2 = Timer.periodic(
    //     Duration(seconds: (current_page == 4) ? 3 : 1),
    //     (timer) async {
    //   Room room = rooms[
    //       (current_page > 1) ? current_page - 1 : 1];
    //   checkRoomSensorConnection(room);
    //   checkRoomLedConnection(room);
    //   checkRoomProjectorConnection(
    //       room, (current_page == 4) ? 3000 : 1000);
    //   if (current_page != 1 && current_page != 2) {
    //     SetButtonControlRoom(room);
    //   }
    // });
  }

  void dispose() {
    // _timer?.cancel();
    // _timer2?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    roomdata = getRoomData('room_1');
    listProjector = getListProjector(0);
    final page = (current_page > 0) ? current_page - 1 : 0;
    Room room = rooms[page];
    if (page != oldPage) {
      oldPage = page;
      // room.setRoomVolume();
      print('oldPage: $oldPage');
    }

    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: Container(
                // height: (current_page == 1 &&
                //         Responsive.isDesktop(context))
                //     ? SizeConfig.screenHeight
                //     : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<RoomData>(
                        future: roomdata,
                        builder: (BuildContext context,
                            AsyncSnapshot<RoomData> projector_snapshot) {
                          switch (projector_snapshot.connectionState) {
                            case ConnectionState.none:
                              return SizedBox();
                            case ConnectionState.waiting:
                              return const CircularProgressIndicator();
                            case ConnectionState.active:
                            case ConnectionState.done:
                              print(projector_snapshot.data != null);
                              if (projector_snapshot.hasError) {
                                return Text('${projector_snapshot.error}');
                              } else {
                                return Column(
                                  children: [
                                    Text(projector_snapshot.data!.nameUI
                                        .toString()),
                                    Text(projector_snapshot.data!.nameDatabase
                                        .toString()),
                                    Text(projector_snapshot
                                        .data!.power_room_projectors
                                        .toString()),
                                  ],
                                );
                                //   Text(
                                //   '${projector_snapshot.data?.toJson().toString()}',
                                // );
                              }
                          }
                        }),

                    Header(
                      room: room,
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),

                    /// Preset
                    if (room.presets!.length != 0)
                      Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 4,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.movie_filter,
                                  size: 25,
                                  color: AppColors.grey,
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeVertical,
                                ),
                                PrimaryText(
                                    text: 'Nội dung'.toUpperCase(),
                                    size: 20,
                                    color: AppColors.grey,
                                    fontWeight: FontWeight.w500),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
                            decoration: BoxDecoration(
                              color: AppColors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                        room.presets!.length, (index) {
                                      bool isSelected =
                                          room.current_preset == index;
                                      return GestureDetector(
                                        onTap: () {
                                          select_preset(room, index);
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AnimatedContainer(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              curve: Curves.easeInOut,
                                              width: isSelected ? 250.0 : 160.0,
                                              height:
                                                  isSelected ? 250.0 : 160.0,
                                              margin: EdgeInsets.all(20.0),
                                              decoration: BoxDecoration(
                                                color: isSelected
                                                    ? AppColors.navy_blue2
                                                    : AppColors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        isSelected ? 20.0 : 15),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(
                                                    isSelected ? 8.0 : 5.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          isSelected
                                                              ? 15.0
                                                              : 10),
                                                  child: Image.asset(
                                                    room.presets![index].image,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                if (isSelected &&
                                                    (current_page == 3 ||
                                                        current_page == 4))
                                                  SizedBox(
                                                    height: 15,
                                                    width: 230,
                                                    child: Container(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child:
                                                            LinearProgressIndicator(
                                                          value: (room.current_preset <
                                                                  room.presets!
                                                                      .length)
                                                              ? room
                                                                  .presets![room
                                                                      .current_preset]
                                                                  .transport
                                                              : 0,
                                                          semanticsLabel:
                                                              'Linear progress indicator',
                                                          color: AppColors
                                                              .navy_blue2,
                                                          backgroundColor:
                                                              AppColors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                if (isSelected)
                                                  SizedBox(
                                                      height: SizeConfig
                                                              .blockSizeVertical *
                                                          1.5),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .local_movies_outlined,
                                                      size:
                                                          isSelected ? 26 : 18,
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
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 17.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)
                                                          : TextStyle(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 12.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                      duration: const Duration(
                                                          milliseconds: 200),
                                                      child: Text(room
                                                          .presets![index]
                                                          .name),
                                                    ),
                                                    // PrimaryText(
                                                    //     text: room.presets![index].name,
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
                                // (current_page == 1)?
                                VolumeEdit(
                                  room: room,
                                  server: room.servers![0],
                                ),
                                // (current_page == 2)
                                //     ? VolumeEdit(
                                //         room: room,
                                //         server: room.servers![7],
                                //       )
                                //     : VolumeEdit(
                                //         room: room,
                                //         server: room.servers![0],
                                //       ),
                              ],
                            ),
                          ),
                        ],
                      ),

                    /// Map
                    Column(
                      children: [
                        MiniMap(
                          room:
                              rooms[(current_page > 0) ? current_page - 1 : 1],
                          page: current_page,
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
                              width: SizeConfig.blockSizeHorizontal,
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
                              width: SizeConfig.blockSizeHorizontal,
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
                              width: SizeConfig.blockSizeHorizontal,
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
                              width: SizeConfig.blockSizeHorizontal,
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

                    /// Server
                    if (room.resolume)
                      Column(children: [
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 8,
                          child: Row(
                            children: [
                              Icon(
                                Icons.airplay,
                                size: 25,
                                color: AppColors.grey,
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeVertical,
                              ),
                              PrimaryText(
                                  text: 'Quản lý server'.toUpperCase(),
                                  color: AppColors.grey,
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
                                  room.servers!.length,
                                  (index) => InfoServer(
                                      room: room, server: room.servers![index]),
                                ))),

                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 4,
                        ),
                      ]),
                    // if (current_page != 0 &&
                    //     current_page != 1 &&
                    //     current_page != 2)
                    /// Projector
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {

                            });
                          },
                          child: SizedBox(
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
                                    color: AppColors.grey,
                                    size: 20,
                                    fontWeight: FontWeight.w500),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          // height: Responsive.isDesktop(context)? 180:null,
                          // constraints: BoxConstraints(minWidth: Responsive.isDesktop(context) ? 300 : SizeConfig.screenWidth - 40,
                          //     maxWidth: Responsive.isDesktop(context) ? SizeConfig.screenWidth/2-150: SizeConfig.screenWidth- 40),
                          margin: EdgeInsets.only(bottom: 30),
                          padding: EdgeInsets.only(
                              top: 20, bottom: 20, left: 20, right: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  PrimaryText(
                                    text: "Bật/tắt toàn bộ máy chiếu",
                                    color: AppColors.grey,
                                    size: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      width: SizeConfig.blockSizeHorizontal,
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 60,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            room.power_room_projectors
                                                ? AppColors.navy_blue
                                                : AppColors.grey,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          PowerRoomProjectors(room, true);
                                        });
                                      },
                                      child: PrimaryText(
                                        text: 'On',
                                        size: 14,
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                    child: Container(
                                      height: 40,
                                      width: 60,
                                      child: Hero(
                                        tag: heroOffProjector,
                                        createRectTween: (begin, end) {
                                          return CustomRectTween(
                                              begin: begin, end: end);
                                        },
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                !room.power_room_projectors
                                                    ? AppColors.red
                                                    : AppColors.grey,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              Navigator.of(context).push(
                                                  HeroDialogRoute(
                                                      builder: (context) {
                                                return PopupOffProjector(
                                                  onUpdateState: () {
                                                    setState(() {});
                                                  },
                                                );
                                              }));
                                            });
                                          },
                                          child: PrimaryText(
                                            text: 'Off',
                                            size: 14,
                                            color: AppColors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 2,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  PrimaryText(
                                    text: "Bật/tắt toàn bộ màn chập",
                                    color: AppColors.grey,
                                    size: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      width: SizeConfig.blockSizeHorizontal,
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 60,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            room.shutter_room_projectors
                                                ? AppColors.navy_blue
                                                : AppColors.grey,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          ShutterRoomProjectors(room, true);
                                        });
                                      },
                                      child: PrimaryText(
                                        text: 'On',
                                        size: 14,
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                    child: Container(
                                      height: 40,
                                      width: 60,
                                      child: Hero(
                                        tag: heroOffShutter,
                                        createRectTween: (begin, end) {
                                          return CustomRectTween(
                                              begin: begin, end: end);
                                        },
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                !room.shutter_room_projectors
                                                    ? AppColors.red
                                                    : AppColors.grey,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              Navigator.of(context).push(
                                                  HeroDialogRoute(
                                                      builder: (context) {
                                                return PopupOffShutter(
                                                  onUpdateState: () {
                                                    setState(() {});
                                                  },
                                                );
                                              }));
                                              // ShutterAllProjectors(false);
                                            });
                                          },
                                          child: PrimaryText(
                                            text: 'Off',
                                            size: 14,
                                            color: AppColors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        FutureBuilder<List<Projector>>(
                            future: listProjector,
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Projector>>
                                    projectors_snapshot) {
                              switch (projectors_snapshot.connectionState) {
                                case ConnectionState.none:
                                  return SizedBox();
                                case ConnectionState.waiting:
                                  return const CircularProgressIndicator();
                                case ConnectionState.active:
                                case ConnectionState.done:
                                  if (projectors_snapshot.hasError) {
                                    return Text('${projectors_snapshot.error}');
                                  } else {
                                    return SizedBox(
                                      width: SizeConfig.screenWidth,
                                      child: projectors_snapshot.data!.length >
                                              0
                                          ? Wrap(
                                              spacing: 20,
                                              runSpacing: 20,
                                              children: [
                                                Wrap(
                                                  spacing: 20,
                                                  runSpacing: 20,
                                                  children: [
                                                    Container(
                                                      constraints: BoxConstraints(
                                                          minWidth: 280,
                                                          maxWidth: SizeConfig
                                                                      .screenWidth /
                                                                  3 -
                                                              110),
                                                      height: 245,
                                                      padding:
                                                          EdgeInsets.all(20),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: AppColors.white,
                                                      ),
                                                      child: Center(
                                                        child: Hero(
                                                          tag:
                                                              heroAddProjectorNew,
                                                          createRectTween:
                                                              (begin, end) {
                                                            return CustomRectTween(
                                                                begin: begin,
                                                                end: end);
                                                          },
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .push(HeroDialogRoute(
                                                                      builder:
                                                                          (context) {
                                                                return PopupAddProjectorNew();
                                                              }));
                                                            },
                                                            child: PrimaryText(
                                                              text: '+',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              size: 80,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    InfoProjector(
                                                        projector:
                                                            projectors_snapshot
                                                                .data![0])
                                                  ],
                                                ),
                                                Wrap(
                                                    spacing: 20,
                                                    runSpacing: 20,
                                                    alignment: WrapAlignment
                                                        .spaceBetween,
                                                    children: List.generate(
                                                      projectors_snapshot
                                                              .data!.length -
                                                          1,
                                                      (index) =>
                                                          // if(index>0)
                                                          InfoProjector(
                                                              projector:
                                                                  projectors_snapshot
                                                                          .data![
                                                                      index +
                                                                          1]),
                                                    )),
                                              ],
                                            )
                                          : Container(
                                              constraints: BoxConstraints(
                                                  minWidth: 280,
                                                  maxWidth:
                                                      SizeConfig.screenWidth /
                                                              3 -
                                                          110),
                                              height: 245,
                                              padding: EdgeInsets.all(20),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: AppColors.white,
                                              ),
                                              child: Center(
                                                child: Hero(
                                                  tag:
                                                  heroAddProjectorNew,
                                                  createRectTween:
                                                      (begin, end) {
                                                    return CustomRectTween(
                                                        begin: begin,
                                                        end: end);
                                                  },
                                                  child:
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(
                                                          context)
                                                          .push(HeroDialogRoute(
                                                          builder:
                                                              (context) {
                                                            return PopupAddProjectorNew();
                                                          }));
                                                    },
                                                    child: PrimaryText(
                                                      text: '+',
                                                      fontWeight:
                                                      FontWeight
                                                          .w300,
                                                      size: 80,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ),
                                      // : SpinKitThreeBounce(
                                      //     color: AppColors.navy_blue,
                                      //     size: 20,
                                      //   ),
                                    );
                                    //   Text(
                                    //   '${projectors_snapshot.data?.toJson().toString()}',
                                    // );
                                  }
                              }
                            }),
                        // SizedBox(
                        //   width: SizeConfig.screenWidth,
                        //   child: room.projectors!.length > 0
                        //       ? Wrap(
                        //           spacing: 20,
                        //           runSpacing: 20,
                        //           children: [
                        //             Wrap(
                        //               spacing: 20,
                        //               runSpacing: 20,
                        //               children: [
                        //                 Container(
                        //                   constraints: BoxConstraints(
                        //                       minWidth: 280,
                        //                       maxWidth:
                        //                           SizeConfig.screenWidth / 3 -
                        //                               110),
                        //                   height: 245,
                        //                   padding: EdgeInsets.all(20),
                        //                   decoration: BoxDecoration(
                        //                     borderRadius:
                        //                         BorderRadius.circular(20),
                        //                     color: AppColors.white,
                        //                   ),
                        //                   child: Center(
                        //                     child: Hero(
                        //                       tag: heroAddProjectorNew,
                        //                       createRectTween: (begin, end) {
                        //                         return CustomRectTween(
                        //                             begin: begin, end: end);
                        //                       },
                        //                       child: GestureDetector(
                        //                         onTap: () {
                        //                           Navigator.of(context).push(
                        //                               HeroDialogRoute(
                        //                                   builder: (context) {
                        //                             return PopupAddProjectorNew();
                        //                           }));
                        //                         },
                        //                         child: PrimaryText(
                        //                           text: '+',
                        //                           fontWeight: FontWeight.w300,
                        //                           size: 80,
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //                 InfoProjector(
                        //                     projector: room.projectors![0])
                        //               ],
                        //             ),
                        //             Wrap(
                        //                 spacing: 20,
                        //                 runSpacing: 20,
                        //                 alignment: WrapAlignment.spaceBetween,
                        //                 children: List.generate(
                        //                   room.projectors!.length - 1,
                        //                   (index) =>
                        //                       // if(index>0)
                        //                       InfoProjector(
                        //                           projector: room
                        //                               .projectors![index + 1]),
                        //                 )),
                        //           ],
                        //         )
                        //       : Container(
                        //           constraints: BoxConstraints(
                        //               minWidth: 280,
                        //               maxWidth:
                        //                   SizeConfig.screenWidth / 3 - 110),
                        //           height: 245,
                        //           padding: EdgeInsets.all(20),
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(20),
                        //             color: AppColors.white,
                        //           ),
                        //           child: Center(
                        //             child: GestureDetector(
                        //               child: PrimaryText(
                        //                 text: '+',
                        //                 fontWeight: FontWeight.w300,
                        //                 size: 80,
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //   // : SpinKitThreeBounce(
                        //   //     color: AppColors.navy_blue,
                        //   //     size: 20,
                        //   //   ),
                        // ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 4,
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 4,
                        ),
                      ],
                    ),
                    // if (!Responsive.isDesktop(context))
                    //   CheckConnectionBar(room: room)
                  ],
                ),
              ),
            ),
          ),
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
