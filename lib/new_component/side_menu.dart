import 'package:flutter/material.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/data/menu.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';
import 'package:rive/rive.dart';

class SideMenu extends StatelessWidget {
  const SideMenu(
      {@required this.menu,
      @required this.press,
      @required this.riveOnInit,
      @required this.selectedMenu});

  final Menu menu;
  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;
  final Menu selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // const Padding(
        //   padding: EdgeInsets.all(10),
        //   // child: Divider(color: Colors.white24, height: 1),
        // ),
        Container(
          height: 70,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                width: selectedMenu == menu ? 160 : 0,
                height: 70,
                left: 0,
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    color: AppColors.navy_blue,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: press,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 36,
                        width: 36,
                        child: RiveAnimation.asset(
                          menu.rive.src,
                          artboard: menu.rive.artboard,
                          onInit: riveOnInit,
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal*0.5),
                      PrimaryText(
                        text: menu.title,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
              // ListTile(
              //   onTap: press,
              //   leading: SizedBox(
              //     height: 36,
              //     width: 36,
              //     child: RiveAnimation.asset(
              //       menu.rive.src,
              //       artboard: menu.rive.artboard,
              //       onInit: riveOnInit,
              //     ),
              //   ),
              //   title: PrimaryText(
              //     text: menu.title,
              //     color: AppColors.primary,
              //     fontWeight: FontWeight.w400,
              //     size: 18,
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
