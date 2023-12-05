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
  final VoidCallback update;
  final VoidCallback delete;
  final ValueChanged<Artboard> riveOnInit;
  final int selectedMenu;
  const SideMenu(
      {required this.menu,
      required this.id,
      required this.press,
      required this.update,
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
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Padding(
                      //   padding:  EdgeInsets.only(bottom: 18.0),
                      //   child: SizedBox(
                      //     height: 36,
                      //     width: 36,
                      //     child: RiveAnimation.asset(
                      //       menu.rive.src,
                      //       artboard: menu.rive.artboard,
                      //       onInit: riveOnInit,
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(width: 3),
                      Container(
                        alignment: Alignment.centerLeft,
                        // padding: EdgeInsets.only(left: .0),
                        width: 120, // Max width for the text
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
                child: Container(
                  padding: const EdgeInsets.fromLTRB(155, 25, 0, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: update,
                        child: Icon(
                          Icons.edit_outlined,
                          color: AppColors.primary,
                          size: 16,
                        ),
                      ),
                      SizedBox(width: 5,),
                      GestureDetector(
                        onTap: delete,
                        child: Icon(
                          Icons.cancel_outlined,
                          color: AppColors.primary,
                          size: 16,
                        ),
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
