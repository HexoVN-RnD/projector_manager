import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_dashboard/component/appBarActionItems.dart';
import 'package:responsive_dashboard/component/ConnectionDetailList.dart';
import 'package:responsive_dashboard/component/rive_utils.dart';
import 'package:responsive_dashboard/component/side_menu2.dart';
import 'package:responsive_dashboard/data/menu.dart';
import 'package:responsive_dashboard/pages/select_page.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/style/colors.dart';
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
      _drawerKey.currentState.closeDrawer();
      current_page.setValue(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _drawerKey,
      drawer: SizedBox(width: 100, child: Drawer(
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
                    iconSize: 20,
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    icon: SvgPicture.asset(
                      'assets/home.svg',
                      color: current_page.getValue() == 0 ? AppColors.navy_blue : AppColors.iconGray,
                    ),
                    onPressed: () => changePage(0)),
                IconButton(
                    iconSize: 20,
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    icon: SvgPicture.asset(
                      'assets/pie-chart.svg',
                      color: current_page.getValue() == 1 ? AppColors.navy_blue : AppColors.iconGray,
                    ),
                    onPressed: () => changePage(1)),
                IconButton(
                    iconSize: 20,
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    icon: SvgPicture.asset(
                      'assets/pie-char.svg',
                      color: current_page.getValue() == 2 ? AppColors.navy_blue : AppColors.iconGray,
                    ),
                    onPressed: () => changePage(2)),
                IconButton(
                    iconSize: 20,
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    icon: SvgPicture.asset(
                      'assets/pie-char.svg',
                      color: current_page.getValue() == 3 ? AppColors.navy_blue : AppColors.iconGray,
                    ),
                    onPressed: () => changePage(3)),
                IconButton(
                    iconSize: 20,
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    icon: SvgPicture.asset(
                      'assets/pie-char.svg',
                      color: current_page.getValue() == 4 ? AppColors.navy_blue : AppColors.iconGray,
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
                    _drawerKey.currentState.openDrawer();
                  },
                  icon: Icon(Icons.menu, color: AppColors.black)),
              actions: [
                AppBarActionItems(),
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
              Expanded(
                flex: 2,
                child: Column(
                  children:
                    List.generate(
                      sidebarMenus.length,
                          (index) => SideMenu(
                            menu: sidebarMenus[index],
                              selectedMenu: selectedSideMenu,
                              press: () {
                                RiveUtils.changeSMIBoolState(sidebarMenus[index].rive.status);
                                setState(() {
                                  selectedSideMenu = sidebarMenus[index];
                                  current_page.setValue(index);
                                });
                              },
                              riveOnInit: (artboard) {
                                sidebarMenus[index].rive.status = RiveUtils.getRiveInput(artboard,
                                    stateMachineName: sidebarMenus[index].rive.stateMachineName);
                              },
                      ),
                    ),

                ),
              ),
            Expanded(flex: 10, child: SelectPage()),
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 4,
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
                          PaymentDetailList(),
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
