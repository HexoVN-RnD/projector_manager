import 'package:flutter/material.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/data/menu.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';
import 'package:rive/rive.dart';

class HomeMenu extends StatelessWidget {
  final Menu menu;
  final int id;
  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;
  final int selectedMenu;
  const HomeMenu(
      {required this.menu,
        required this.id,
        required this.press,
        required this.riveOnInit,
        required this.selectedMenu});

  @override
  Widget build(BuildContext context) {
    // print(selectedMenu == id);
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
                duration: Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                width: selectedMenu == id ? 200 : 0,
                height: 70,
                left: 0,
                child: Container(
                  height: 70,
                  decoration: const BoxDecoration(
                    color: AppColors.navy_blue,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              // Container(
              //   height: 70,
              //   width: selectedMenu.title == menu.title ? 200 : 0,
              //   decoration: const BoxDecoration(
              //     color: AppColors.navy_blue,
              //     borderRadius: BorderRadius.all(Radius.circular(10)),
              //   ),
              // ),
              GestureDetector(
                onTap: press,
                child: Container(
                  width: 200,
                  height: 70,
                  padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 7.0),
                        child: PrimaryText(
                          text: menu.title,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
