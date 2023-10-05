import 'dart:io';
import 'dart:async';
import 'dart:ui';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_dashboard/Method/ping_check_connection.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/PopUp/MiniMap.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/new_component/projectorConnection.dart';
import 'package:responsive_dashboard/new_component/sensorConnection.dart';
import 'package:responsive_dashboard/new_component/serverConnection.dart';
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

final StatefulValuable<int> current_page = StatefulValuable<int>(0);

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
  Menu selectedSideMenu = sidebarMenus.first;
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
      current_page.setValue(index);
    });
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      getLicenseStatus();
      Future.delayed(
        const Duration(milliseconds: 500),
            () {
          setState(() {
            allRoom.canRun.setValue(license_status.any((status) {
              final license_status =
              status['run'].toString();
              return license_status == 'true';
            }));
          });
        },
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final width = SizeConfig.screenWidth;
    final height = SizeConfig.screenHeight;
    Room room =
        rooms[(current_page.getValue() > 0) ? current_page.getValue() - 1 : 0];

    return Stack(
      children: [
        Scaffold(
          key: _drawerKey,
          drawer: SizedBox(
              width: 100,
              child: Drawer(
                elevation: 0,
                child: Container(
                  width: double.infinity,
                  height: SizeConfig.screenHeight,
                  decoration: BoxDecoration(color: AppColors.secondaryBg),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            iconSize: 30,
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            icon: RiveAnimation.asset(
                              "assets/RiveAssets/icons.riv",
                              artboard: "HOME",
                              // onInit: riveOnInit,
                            ),
                            onPressed: () => changePage(0)),
                        IconButton(
                            iconSize: 30,
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            icon: RiveAnimation.asset(
                              "assets/RiveAssets/icons.riv",
                              artboard: "ROOM",
                              // onInit: riveOnInit,
                            ),
                            onPressed: () => changePage(1)),
                        IconButton(
                            iconSize: 30,
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            icon: RiveAnimation.asset(
                              "assets/RiveAssets/icons.riv",
                              artboard: "ROOM",
                              // onInit: riveOnInit,
                            ),
                            onPressed: () => changePage(2)),
                        IconButton(
                            iconSize: 30,
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            icon: RiveAnimation.asset(
                              "assets/RiveAssets/icons.riv",
                              artboard: "ROOM",
                              // onInit: riveOnInit,
                            ),
                            onPressed: () => changePage(3)),
                        IconButton(
                            iconSize: 30,
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            icon: RiveAnimation.asset(
                              "assets/RiveAssets/icons.riv",
                              artboard: "ROOM",
                              // onInit: riveOnInit,
                            ),
                            onPressed: () => changePage(4)),
                        Expanded(
                          child: IconButton(
                              iconSize: 30,
                              padding: EdgeInsets.symmetric(vertical: 20.0),
                              icon: RiveAnimation.asset(
                                "assets/RiveAssets/icons.riv",
                                artboard: "ROOM",
                                // onInit: riveOnInit,
                              ),
                              onPressed: () => changePage(4)),
                        ),
                        Expanded(
                          child: IconButton(
                              iconSize: 30,
                              padding: EdgeInsets.symmetric(vertical: 20.0),
                              icon: RiveAnimation.asset(
                                "assets/RiveAssets/icons.riv",
                                artboard: "ROOM",
                                // onInit: riveOnInit,
                              ),
                              onPressed: () => changePage(4)),
                        ),
                        Expanded(
                          child: IconButton(
                              iconSize: 30,
                              padding: EdgeInsets.symmetric(vertical: 20.0),
                              icon: RiveAnimation.asset(
                                "assets/RiveAssets/icons.riv",
                                artboard: "ROOM",
                                // onInit: riveOnInit,
                              ),
                              onPressed: () => changePage(4)),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          appBar: !Responsive.isDesktop(context)
              ? AppBar(
                  elevation: 0,
                  backgroundColor: AppColors.white,
                  leading: IconButton(
                      onPressed: () {
                        _drawerKey.currentState?.openDrawer();
                      },
                      icon: Icon(Icons.menu, color: AppColors.black)),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppBarActionItems(),
                    ),
                  ],
                )
              : PreferredSize(
                  preferredSize: Size.zero,
                  child: SizedBox(),
                ),
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (Responsive.isDesktop(context))
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
                      Column(
                        children: List.generate(
                          sidebarMenus.length,
                          (index) => SideMenu(
                            menu: sidebarMenus[index],
                            selectedMenu: selectedSideMenu,
                            press: () {
                              RiveUtils.changeSMIBoolState(
                                  sidebarMenus[index].rive.status!);
                              setState(() {
                                changePage(index);
                              });
                            },
                            riveOnInit: (artboard) {
                              sidebarMenus[index].rive.status =
                                  RiveUtils.getRiveInput(artboard,
                                      stateMachineName: sidebarMenus[index]
                                          .rive
                                          .stateMachineName);
                            },
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
        if (allRoom.canRun.getValue() == false) Positioned.fill(
          child: Container(
            color: Colors.transparent,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: const SizedBox(),
            ),
          ),
        ),
        if (allRoom.canRun.getValue() == false) Center(
          child: SingleChildScrollView(
            child: Container(
              width: SizeConfig.screenWidth / 2,
              height: SizeConfig.screenHeight / 3,
              // decoration: BoxDecoration(
              //     color: AppColors.gray,
              //     borderRadius: BorderRadius.circular(30)),
              child: Material(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                child: Container(
                  width: 300,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                        child: PrimaryText(
                          text: 'License đã hết hạn'.toUpperCase(),
                          size: 20,
                          color: AppColors.gray,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 60),
                        child: PrimaryText(
                          text: 'Vui lòng liên hệ nhà cung cấp để gia hạn'
                              .toUpperCase(),
                          size: 20,
                          color: AppColors.gray,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        width: 160,
                        height: 70,
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              exit(0);
                              // print('exit: $license_status $canRun');
                            });
                          },
                          child: PrimaryText(
                            text: 'Exit'.toUpperCase(),
                            size: 16,
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
