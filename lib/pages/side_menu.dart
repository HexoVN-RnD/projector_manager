import 'package:flutter/material.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/data/menu.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';
import 'package:rive/rive.dart';

class SideMenu extends StatelessWidget {
  final Menu menu;
  final int id;
  final VoidCallback press;
  final VoidCallback delete;
  final ValueChanged<Artboard> riveOnInit;
  final int selectedMenu;
  const SideMenu(
      {required this.menu,
      required this.id,
      required this.press,
      required this.delete,
      required this.riveOnInit,
      required this.selectedMenu});

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
                width: id == selectedMenu ? 200 : 0,
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
                  padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(bottom: 18.0),
                        child: SizedBox(
                          height: 36,
                          width: 36,
                          child: RiveAnimation.asset(
                            menu.rive.src,
                            artboard: menu.rive.artboard,
                            onInit: riveOnInit,
                          ),
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 0.5),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(bottom: 10.0),
                        width: 100, // Max width for the text
                        child: FittedBox(
                          fit: BoxFit.scaleDown, // Scale down to fit within the box
                          child: PrimaryText(
                            text: menu.title,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                            size: 16,
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 7.0),
                      //   child: PrimaryText(
                      //     text: menu.title,
                      //     color: AppColors.primary,
                      //     fontWeight: FontWeight.w500,
                      //     size: 16,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Positioned(
                child: GestureDetector(
                  onTap: delete,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(165, 22, 0, 0),
                    child: Icon(
                      Icons.cancel_outlined,
                      color: AppColors.red,
                    ),
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
