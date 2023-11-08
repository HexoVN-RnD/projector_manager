import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/style/colors.dart';

class SideMenu extends StatefulWidget {
  const SideMenu();

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  _SideMenuState();

  void changePage(int index) {
    setState(() {
      // _drawerKey.currentState.openDrawer();
      current_page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                    color: current_page == 0 ? AppColors.navy_blue : AppColors.iconGray,
                  ),
                  onPressed: () => changePage(0)),
              IconButton(
                  iconSize: 20,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  icon: SvgPicture.asset(
                    'assets/pie-chart.svg',
                    color: current_page == 1 ? AppColors.navy_blue : AppColors.iconGray,
                  ),
                  onPressed: () => changePage(1)),
              IconButton(
                  iconSize: 20,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  icon: SvgPicture.asset(
                    'assets/clipboard.svg',
                    color: current_page == 2 ? AppColors.navy_blue : AppColors.iconGray,
                  ),
                  onPressed: () => changePage(2)),
              IconButton(
                  iconSize: 20,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  icon: SvgPicture.asset(
                    'assets/credit-card.svg',
                    color: current_page == 3 ? AppColors.navy_blue : AppColors.iconGray,
                  ),
                  onPressed: () => changePage(3)),
              IconButton(
                  iconSize: 20,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  icon: SvgPicture.asset(
                    'assets/trophy.svg',
                    color: current_page == 4 ? AppColors.navy_blue : AppColors.iconGray,
                  ),
                  onPressed: () => changePage(4)),
              IconButton(
                  iconSize: 20,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  icon: SvgPicture.asset(
                    'assets/invoice.svg',
                    color: current_page == 5 ? AppColors.navy_blue : AppColors.iconGray,
                  ),
                  onPressed: () => changePage(5)),
            ],
          ),
        ),
      ),
    );
  }
}

