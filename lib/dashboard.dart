import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_dashboard/pages/appBarActionItems.dart';
import 'package:responsive_dashboard/pages/checkConnectionBar.dart';
import 'package:responsive_dashboard/component/rive_utils.dart';
import 'package:responsive_dashboard/pages/side_menu.dart';
import 'package:responsive_dashboard/data/menu.dart';
import 'package:responsive_dashboard/pages/select_page.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:rive/rive.dart';
import 'package:valuable/valuable.dart';

final StatefulValuable<int> current_page = StatefulValuable<int>(0);

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  Menu selectedSideMenu = sidebarMenus.first;

  void changePage(int index) {
    setState(() {
      _drawerKey.currentState?.closeDrawer();
      selectedSideMenu = sidebarMenus[index];
      current_page.setValue(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
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
                    print('done');
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
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Container(
                width: 200,
                decoration: BoxDecoration(
                  color: AppColors.barBg,
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(30))
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20,0,20,0),
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
                                    stateMachineName:
                                        sidebarMenus[index].rive.stateMachineName);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(flex: 10, child: SelectPage()),
            if (Responsive.isDesktop(context) && current_page.getValue() != 0)
              Expanded(
                flex: 5,
                child: SafeArea(
                  child: Container(
                    width: double.infinity,
                    height: SizeConfig.screenHeight,
                    decoration: BoxDecoration(color: AppColors.secondaryBg),
                    child: SingleChildScrollView(
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                      child: Column(
                        children: [
                          AppBarActionItems(),
                          CheckConnectionBar(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
