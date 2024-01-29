import 'dart:io';
import 'dart:async';
import 'dart:ui';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_dashboard/Method/Control_all_projectors_void.dart';
import 'package:responsive_dashboard/Method/Osc_void.dart';
import 'package:responsive_dashboard/Method/ping_check_connection.dart';
import 'package:responsive_dashboard/Method/udp_void.dart';
import 'package:responsive_dashboard/Object/Preset.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/PopUp/HeroDialogRoute.dart';
import 'package:responsive_dashboard/PopUp/MiniMap.dart';
import 'package:responsive_dashboard/PopUp/PopupOffProjector.dart';
import 'package:responsive_dashboard/PopUp/PopupOffShutter.dart';
import 'package:responsive_dashboard/PopUp/customRectTween.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/main.dart';
import 'package:responsive_dashboard/new_component/header.dart';
import 'package:responsive_dashboard/new_component/info_projector.dart';
import 'package:responsive_dashboard/new_component/info_server.dart';
import 'package:responsive_dashboard/new_component/projectorConnection.dart';
import 'package:responsive_dashboard/new_component/sensorConnection.dart';
import 'package:responsive_dashboard/new_component/serverConnection.dart';
import 'package:responsive_dashboard/new_component/volume_edit.dart';
import 'package:responsive_dashboard/pages/appBarActionItems.dart';
import 'package:responsive_dashboard/pages/checkConnectionBar.dart';
import 'package:responsive_dashboard/component/rive_utils.dart';
import 'package:responsive_dashboard/pages/side_menu.dart';
import 'package:responsive_dashboard/data/menu.dart';
import 'package:responsive_dashboard/pages/select_page.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';
import 'package:rive/rive.dart';
import 'package:valuable/valuable.dart';

import 'new_component/Preset.dart';

final StatefulValuable<int> current_page = StatefulValuable<int>(1);

class DashboardIpad extends StatefulWidget {
  final VoidCallback? onUpdateState;
  DashboardIpad({
    Key? key,
    this.onUpdateState,
  }) : super(key: key);
  @override
  State<DashboardIpad> createState() => _DashboardIpadState();
}

class _DashboardIpadState extends State<DashboardIpad> {
  // Timer? _timer;
  // Timer? _timer2;
  Timer? _timer3;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  Menu selectedSideMenu = sidebarMenus.first;
  // CollectionReference licenseStatusCollection =
  //     Firestore.instance.collection('license_status');
  // List<Document> license_status = [];
  //
  // Future<List<Document>> getLicenseStatus() async {
  //   license_status = await licenseStatusCollection.orderBy('run').get();
  //   return license_status;
  // }
  // Future<dynamic> getImageUrl(String imagePath) async {
  //   final ref = FirebaseStorage.instance.ref().child(imagePath);
  //   final url = await ref.getDownloadURL();
  //   print(url);
  //   for (Preset preset in rooms[0].presets)
  //     {
  //       preset.image = url;
  //     }
  //   return url;
  // }

  void changePage(int index) {
    setState(() {
      _drawerKey.currentState?.closeDrawer();
      selectedSideMenu = sidebarMenus[index];
      current_page.setValue(index);
    });
  }

  // void select_preset(Room room, int index) async {
  //   setState(() {
  //     room.current_preset.setValue(index);
  //     for (Server server in room.servers) {
  //       if (room.resolume) {
  //         SendPresetOSC(
  //             server.ip, server.preset_port, room.current_preset.getValue());
  //         PlayPreset(current_page.getValue());
  //       } else {
  //         SendUDPMessage(server,
  //             'Preset' + (room.current_preset.getValue() + 1).toString());
  //       }
  //     }
  //   });
  // }

  @override
  void initState() {
    Room room = rooms[0];
    // getImageUrl('gs://'+projectId+'.appspot.com/Preset2.png');
    super.initState();
    // _timer = Timer.periodic(Duration(seconds: 60), (timer) {
    //   // getLicenseStatus();
    //   Future.delayed(
    //     const Duration(milliseconds: 500),
    //         () {
    //       setState(() {
    //         allRoom.canRun.setValue(license_status.any((status) {
    //           final license_status =
    //           status['run'].toString();
    //           return license_status == 'true';
    //         }));
    //       });
    //     },
    //   );
    // });
    // _timer2 = Timer.periodic(Duration(milliseconds: 100), (timer) {
    //   setState(() {
    //     if (room.servers[0].connected.getValue()) {
    //       // print('object');
    //       OSCReceive();
    //     }
    //   });
    // });
    _timer3 = Timer.periodic(Duration(milliseconds: 500), (timer) async {
      setState(() {
        checkRoomProjectorConnection(room, 500);
        SetButtonControlRoom(room);
      });
    });
  }

  @override
  void dispose() {
    // _timer?.cancel();
    // _timer2?.cancel();
    _timer3?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Room room = rooms[0];

    return Scaffold(
      // key: _drawerKey,
      // drawer: SizedBox(
      //     width: 100,
      //     child: Drawer(
      //       elevation: 0,
      //       child: Container(
      //         width: double.infinity,
      //         height: SizeConfig.screenHeight,
      //         decoration: BoxDecoration(color: AppColors.secondaryBg),
      //         child: SingleChildScrollView(
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               IconButton(
      //                   iconSize: 30,
      //                   padding: EdgeInsets.symmetric(vertical: 20.0),
      //                   icon: RiveAnimation.asset(
      //                     "assets/RiveAssets/icons.riv",
      //                     artboard: "HOME",
      //                     // onInit: riveOnInit,
      //                   ),
      //                   onPressed: () => changePage(0)),
      //               IconButton(
      //                   iconSize: 30,
      //                   padding: EdgeInsets.symmetric(vertical: 20.0),
      //                   icon: RiveAnimation.asset(
      //                     "assets/RiveAssets/icons.riv",
      //                     artboard: "ROOM",
      //                     // onInit: riveOnInit,
      //                   ),
      //                   onPressed: () => changePage(1)),
      //               IconButton(
      //                   iconSize: 30,
      //                   padding: EdgeInsets.symmetric(vertical: 20.0),
      //                   icon: RiveAnimation.asset(
      //                     "assets/RiveAssets/icons.riv",
      //                     artboard: "ROOM",
      //                     // onInit: riveOnInit,
      //                   ),
      //                   onPressed: () => changePage(2)),
      //               IconButton(
      //                   iconSize: 30,
      //                   padding: EdgeInsets.symmetric(vertical: 20.0),
      //                   icon: RiveAnimation.asset(
      //                     "assets/RiveAssets/icons.riv",
      //                     artboard: "ROOM",
      //                     // onInit: riveOnInit,
      //                   ),
      //                   onPressed: () => changePage(3)),
      //               IconButton(
      //                   iconSize: 30,
      //                   padding: EdgeInsets.symmetric(vertical: 20.0),
      //                   icon: RiveAnimation.asset(
      //                     "assets/RiveAssets/icons.riv",
      //                     artboard: "ROOM",
      //                     // onInit: riveOnInit,
      //                   ),
      //                   onPressed: () => changePage(4)),
      //               Expanded(
      //                 child: IconButton(
      //                     iconSize: 30,
      //                     padding: EdgeInsets.symmetric(vertical: 20.0),
      //                     icon: RiveAnimation.asset(
      //                       "assets/RiveAssets/icons.riv",
      //                       artboard: "ROOM",
      //                       // onInit: riveOnInit,
      //                     ),
      //                     onPressed: () => changePage(4)),
      //               ),
      //               Expanded(
      //                 child: IconButton(
      //                     iconSize: 30,
      //                     padding: EdgeInsets.symmetric(vertical: 20.0),
      //                     icon: RiveAnimation.asset(
      //                       "assets/RiveAssets/icons.riv",
      //                       artboard: "ROOM",
      //                       // onInit: riveOnInit,
      //                     ),
      //                     onPressed: () => changePage(4)),
      //               ),
      //               Expanded(
      //                 child: IconButton(
      //                     iconSize: 30,
      //                     padding: EdgeInsets.symmetric(vertical: 20.0),
      //                     icon: RiveAnimation.asset(
      //                       "assets/RiveAssets/icons.riv",
      //                       artboard: "ROOM",
      //                       // onInit: riveOnInit,
      //                     ),
      //                     onPressed: () => changePage(4)),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     )),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        // leading: Image.asset(
        //   "assets/LogoOCB.png",
        // ),
        title: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 10),
          // width: 1000,
          child: Image.asset(
            "assets/LogoOCB.png",
            width: 100,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppBarActionItems(),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Container(
              height: (current_page.getValue() == 1 &&
                      Responsive.isDesktop(context))
                  ? SizeConfig.screenHeight
                  : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(
                    room: room,
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
                    decoration: BoxDecoration(
                      color: AppColors.ocb,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20),
                          height: SizeConfig.blockSizeVertical * 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.movie_filter,
                                size: 30,
                                color: AppColors.white,
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal,
                              ),
                              PrimaryText(
                                  color: AppColors.white,
                                  text: 'Nội dung',
                                  size: 20,
                                  fontWeight: FontWeight.w500),
                              Expanded(
                                child: SizedBox(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    PrimaryText(
                                        color: AppColors.white,
                                        text: (DateTime.now().hour < 10)
                                            ? '0' +
                                            DateTime.now().hour.toString()
                                            : DateTime.now().hour.toString(),
                                        size: 20,
                                        fontWeight: FontWeight.w500),
                                    PrimaryText(
                                        color: AppColors.white,
                                        text: (DateTime.now().minute < 10)
                                            ? ':0' +
                                            DateTime.now()
                                                .minute
                                                .toString()
                                            : ':' +
                                            DateTime.now()
                                                .minute
                                                .toString(),
                                        size: 20,
                                        fontWeight: FontWeight.w500),
                                    PrimaryText(
                                        color: AppColors.white,
                                        text: (DateTime.now().second < 10)
                                            ? ':0' +
                                            DateTime.now()
                                                .second
                                                .toString()
                                            : ':' +
                                            DateTime.now()
                                                .second
                                                .toString(),
                                        size: 20,
                                        fontWeight: FontWeight.w500),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                          // constraints: BoxConstraints(
                          //   minHeight: 200.0,
                          //   maxHeight: 500.0,
                          // ),
                          // width: SizeConfig.screenWidth-100,
                          // color: Colors.transparent,
                          child:
                                 Scrollbar(
                                  // thumbVisibility: true,
                                  trackVisibility: true,
                                  interactive: true,
                                  radius: Radius.circular(10),
                                  thickness: 8,
                                  child:
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                        children:
                                            List.generate(room.presets.length, (index) {
                                          return PresetUI(index: index);
                                        }
                                        ),
                                      ),
                                  ),
                                )
                            ,
                        ),
                        // (current_page.getValue() == 1)?
                        // Container(
                        //   margin: EdgeInsets.fromLTRB(30, 50, 30, 0),
                        //   height: 20,
                        //   child: ClipRRect(
                        //     borderRadius: BorderRadius.circular(20),
                        //     child: LinearProgressIndicator(
                        //       value: (allRoom.current_preset.getValue() <
                        //           allRoom.presets.length)
                        //           ? allRoom
                        //           .presets[
                        //       allRoom.current_preset.getValue()]
                        //           .transport
                        //           .getValue()
                        //           : 0,
                        //       semanticsLabel: 'Linear progress indicator',
                        //       color: allRoom.current_colume.getValue() == 1
                        //           ? AppColors.column1
                        //           : allRoom.current_colume.getValue() == 2
                        //           ? AppColors.column2
                        //           : AppColors.column3,
                        //       backgroundColor: AppColors.white,
                        //     ),
                        //   ),
                        // ),
                        VolumeEdit(
                          room: room,
                          server: room.servers[0],
                        ),
                        // (current_page.getValue() == 2)
                        //     ? VolumeEdit(
                        //         room: room,
                        //         server: room.servers[7],
                        //       )
                        //     : VolumeEdit(
                        //         room: room,
                        //         server: room.servers[0],
                        //       ),
                      ],
                    ),
                  ),

                  /// List server
                  Column(children: [
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
                              (index) => InfoServer(
                                  room: room, server: room.servers[index]),
                            ))),

                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 4,
                    ),
                  ]),
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
                                  color: AppColors.gray,
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
                                  width: 70,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          room.power_room_projectors.getValue()
                                              ? AppColors.navy_blue
                                              : AppColors.gray,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
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
                                    width: 70,
                                    child: Hero(
                                      tag: heroOffProjector,
                                      createRectTween: (begin, end) {
                                        return CustomRectTween(
                                            begin: begin, end: end);
                                      },
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: !room
                                                  .power_room_projectors
                                                  .getValue()
                                              ? AppColors.red
                                              : AppColors.gray,
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
                                  color: AppColors.gray,
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
                                  width: 70,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: room
                                              .shutter_room_projectors
                                              .getValue()
                                          ? AppColors.navy_blue
                                          : AppColors.gray,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
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
                                    width: 70,
                                    child: Hero(
                                      tag: heroOffShutter,
                                      createRectTween: (begin, end) {
                                        return CustomRectTween(
                                            begin: begin, end: end);
                                      },
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: !room
                                                  .shutter_room_projectors
                                                  .getValue()
                                              ? AppColors.red
                                              : AppColors.gray,
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
                ],
              ),
            ),
          ),
          // if (allRoom.canRun.getValue() == false) Positioned.fill(
          //   child: Container(
          //     color: Colors.transparent,
          //     child: BackdropFilter(
          //       filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          //       child: const SizedBox(),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
