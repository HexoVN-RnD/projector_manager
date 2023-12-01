import 'dart:io';
import 'dart:async';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/RoomData.dart';
import 'package:responsive_dashboard/Object/rive_model.dart';
import 'package:responsive_dashboard/PopUp/HeroDialogRoute.dart';
import 'package:responsive_dashboard/PopUp/PopupAddRoom.dart';
import 'package:responsive_dashboard/PopUp/customRectTween.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/component/rive_utils.dart';
import 'package:responsive_dashboard/pages/side_menu.dart';
import 'package:responsive_dashboard/data/menu.dart';
import 'package:responsive_dashboard/pages/select_page.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

int current_page = 0;

class Dashboard extends StatefulWidget {
  final VoidCallback? onUpdateState;
  Dashboard({
    Key? key,
    this.onUpdateState,
  }) : super(key: key);
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Timer? _timer;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  late Menu selectedSideMenu;
  List<Menu> sidebarMenus = [Menu(
  title: "Tổng quan".toUpperCase(),
  rive: RiveModel(
  src: "assets/RiveAssets/icons.riv",
  artboard: "HOME",
  stateMachineName: "HOME_interactivity"),
  )];
  late List<RoomData> listRoom = List.empty(growable: true);
  CollectionReference licenseStatusCollection =
      Firestore.instance.collection('license_status');
  List<Document> license_status = [];

  Future<List<Document>> getLicenseStatus() async {
    license_status = await licenseStatusCollection.orderBy('run').get();
    return license_status;
  }

  void changePage(int index) {
    setState(() {
      _drawerKey.currentState?.closeDrawer();
      selectedSideMenu = sidebarMenus[index];
      current_page = index;
    });
  }

  @override
  void initState() {
    getRoom();
    sidebarMenus = [
      Menu(
        title: "Tổng quan".toUpperCase(),
        rive: RiveModel(
            src: "assets/RiveAssets/icons.riv",
            artboard: "HOME",
            stateMachineName: "HOME_interactivity"),
      ),
      ...listRoom
          .map((room) => Menu(
        title: room.nameUI,
        rive: RiveModel(
            src: "assets/RiveAssets/icons.riv",
            artboard: "ROOM",
            stateMachineName: "ROOM_interactivity"),
      ))
          .toList()
    ];
    selectedSideMenu = sidebarMenus.first;
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 60), (timer) {
      getLicenseStatus();
      Future.delayed(
        const Duration(milliseconds: 500),
        () {
          setState(() {
            allRoom.canRun = license_status.any((status) {
              final license_status = status['run'].toString();
              return license_status == 'true';
            });
          });
        },
      );
    });
  }

  Future<void> getRoom() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    listRoom = getListRoom(prefs);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    getRoom();
    sidebarMenus = [
      Menu(
        title: "Tổng quan".toUpperCase(),
        rive: RiveModel(
            src: "assets/RiveAssets/icons.riv",
            artboard: "HOME",
            stateMachineName: "HOME_interactivity"),
      ),
      ...listRoom
          .map((room) => Menu(
                title: room.nameUI,
                rive: RiveModel(
                    src: "assets/RiveAssets/icons.riv",
                    artboard: "ROOM",
                    stateMachineName: "ROOM_interactivity"),
              ))
          .toList()
    ];
    // final width = SizeConfig.screenWidth;
    // final height = SizeConfig.screenHeight;
    // Room room = rooms[(current_page > 0) ? current_page - 1 : 0];

    return Material(
      child: Stack(
        children: [
          Scaffold(
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                      color: AppColors.barBg,
                      borderRadius:
                          BorderRadius.horizontal(right: Radius.circular(30))),
                  child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          alignment: Alignment.centerLeft,
                          height: 84,
                          child: Image.asset(
                            'assets/small_logo.png',
                            // filterQuality: FilterQuality.high,
                            fit: BoxFit.fitHeight,
                          )),
                      SideMenu(
                        menu: sidebarMenus.first,
                        selectedMenu: selectedSideMenu,
                        press: () {
                          RiveUtils.changeSMIBoolState(
                              sidebarMenus[0].rive.status!);
                          setState(() {
                            changePage(0);
                          });
                        },
                        riveOnInit: (artboard) {
                          sidebarMenus[0].rive.status = RiveUtils.getRiveInput(
                              artboard,
                              stateMachineName:
                                  sidebarMenus[0].rive.stateMachineName);
                        },
                      ),
                      if (sidebarMenus.length > 0)
                        Container(
                          height: 700,
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                sidebarMenus.length - 1,
                                (index) => SideMenu(
                                  menu: sidebarMenus[index + 1],
                                  selectedMenu: selectedSideMenu,
                                  press: () {
                                    RiveUtils.changeSMIBoolState(
                                        sidebarMenus[index + 1].rive.status!);
                                    setState(() {
                                      print('index' + (index + 1).toString());
                                      changePage(index + 1);
                                    });
                                  },
                                  riveOnInit: (artboard) {
                                    sidebarMenus[index + 1].rive.status =
                                        RiveUtils.getRiveInput(artboard,
                                            stateMachineName:
                                                sidebarMenus[index + 1]
                                                    .rive
                                                    .stateMachineName);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      Hero(
                        tag: heroAddRoom,
                        createRectTween: (begin, end) {
                          return CustomRectTween(begin: begin, end: end);
                        },
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(HeroDialogRoute(builder: (context) {
                              return PopupAddRoom();
                            }));
                          },
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              alignment: Alignment.center,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: AppColors.navy_blue,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      bottomRight: Radius.circular(15))),
                              // padding: const EdgeInsets.only(bottom: 7.0),
                              child: PrimaryText(
                                text: '+',
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                                size: 36,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            exit(0);
                          },
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              alignment: Alignment.center,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: AppColors.navy_blue,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      bottomRight: Radius.circular(30))),
                              // padding: const EdgeInsets.only(bottom: 7.0),
                              child: PrimaryText(
                                text: 'Exit',
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                                size: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: SelectPage()),
              ],
            ),
          ),
          // if (allRoom.canRun  == false) Positioned.fill(
          //   child: Container(
          //     color: Colors.transparent,
          //     child: BackdropFilter(
          //       filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          //       child: const SizedBox(),
          //     ),
          //   ),
          // ),
          // if (allRoom.canRun  == false) Center(
          //   child: SingleChildScrollView(
          //     child: Container(
          //       width: SizeConfig.screenWidth / 2,
          //       height: SizeConfig.screenHeight / 3,
          //       // decoration: BoxDecoration(
          //       //     color: AppColors.gray,
          //       //     borderRadius: BorderRadius.circular(30)),
          //       child: Material(
          //         color: Colors.white,
          //         elevation: 2,
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(32)),
          //         child: Container(
          //           width: 300,
          //           padding: const EdgeInsets.all(16.0),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Container(
          //                 padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
          //                 child: PrimaryText(
          //                   text: 'License đã hết hạn'.toUpperCase(),
          //                   size: 20,
          //                   color: AppColors.gray,
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //               ),
          //               Container(
          //                 padding: EdgeInsets.fromLTRB(10, 10, 10, 60),
          //                 child: PrimaryText(
          //                   text: 'Vui lòng liên hệ nhà cung cấp để gia hạn'
          //                       .toUpperCase(),
          //                   size: 20,
          //                   color: AppColors.gray,
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //               ),
          //               Container(
          //                 width: 160,
          //                 height: 70,
          //                 margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
          //                 child: ElevatedButton(
          //                   style: ElevatedButton.styleFrom(
          //                     backgroundColor: AppColors.red,
          //                     shape: RoundedRectangleBorder(
          //                       borderRadius: BorderRadius.circular(30),
          //                     ),
          //                   ),
          //                   onPressed: () {
          //                     setState(() {
          //                       exit(0);
          //                       // print('exit: $license_status $canRun');
          //                     });
          //                   },
          //                   child: PrimaryText(
          //                     text: 'Exit'.toUpperCase(),
          //                     size: 16,
          //                     color: AppColors.white,
          //                     fontWeight: FontWeight.w500,
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
