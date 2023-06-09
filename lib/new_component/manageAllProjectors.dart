import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_dashboard/Method/Control_all_projectors_void.dart';
import 'package:responsive_dashboard/PopUp/HeroDialogRoute.dart';
import 'package:responsive_dashboard/PopUp/PopupOffProjector.dart';
import 'package:responsive_dashboard/PopUp/PopupOffShutter.dart';
import 'package:responsive_dashboard/PopUp/customRectTween.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/PopUp/PopupOffServer.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

class ManageAllProjectors extends StatefulWidget {
  @override
  _ManageAllProjectorsState createState() => _ManageAllProjectorsState();
}

class _ManageAllProjectorsState extends State<ManageAllProjectors> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: Responsive.isDesktop(context) ? 180 : null,
      constraints: BoxConstraints(
          // minWidth:
          //     Responsive.isDesktop(context) ? 300 : SizeConfig.screenWidth - 40,
          maxWidth:
              // Responsive.isDesktop(context)
              //     ? SizeConfig.screenWidth / 2 - 135
              //     :
              SizeConfig.screenWidth - 40),
      padding: EdgeInsets.only(
          top: 20,
          bottom: 20,
          left: 20,
          right: Responsive.isMobile(context) ? 20 : 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.gray,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/Icon/settings.png',
                height: 30,
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal,
              ),
              PrimaryText(
                text: 'Projectors Manager',
                color: AppColors.white,
                size: 20,
                fontWeight: FontWeight.w600,
              ),
              Expanded(
                child: SizedBox(
                  width: SizeConfig.blockSizeHorizontal,
                ),
              ),
              // PrimaryText(
              // text: 'num',//projectors.length.toString(),
              // color: AppColors.iconDeepGray,
              // size: 16
              // )
            ],
          ),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     PrimaryText(
          //       text: "Bật/tắt toàn bộ máy chiếu",
          //       color: AppColors.gray,
          //       size: 18,
          //       fontWeight: FontWeight.w500,
          //     ),
          //     Expanded(
          //       child: SizedBox(
          //         width: SizeConfig.blockSizeHorizontal,
          //       ),
          //     ),
          //     Container(
          //       height: 40,
          //       width: 60,
          //       child: ElevatedButton(
          //         style:ElevatedButton.styleFrom(
          //           backgroundColor: allRoom.power_all_projectors.getValue()? AppColors.navy_blue: AppColors.gray,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(20),
          //           ),
          //         ),
          //         onPressed: () {
          //           setState(() {
          //             PowerAllProjectors(true);
          //           });
          //         },
          //         child: PrimaryText(text: 'On',
          //           size: 14,
          //           color: AppColors.white,
          //           fontWeight: FontWeight.w500,),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.fromLTRB(35,0,15,0),
          //       child: Container(
          //         height: 40,
          //         width: 60,
          //         child: Hero(
          //           tag: heroOffProjector,
          //           createRectTween: (begin, end) {
          //             return CustomRectTween(begin: begin, end: end);
          //           },
          //           child: ElevatedButton(
          //             style:ElevatedButton.styleFrom(
          //               backgroundColor: !allRoom.power_all_projectors.getValue()? AppColors.red: AppColors.gray,
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(20),
          //               ),
          //             ),
          //             onPressed: () {
          //               setState(() {
          //                 Navigator.of(context).push(HeroDialogRoute(builder: (context) {
          //                   return PopupOffProjector( onUpdateState: () {
          //                     setState(() {});
          //                   },);
          //                 }));
          //                 // PowerAllProjectors(true);
          //               });
          //             },
          //             child: PrimaryText(text: 'Off',
          //               size: 14,
          //               color: AppColors.white,
          //               fontWeight: FontWeight.w500,),
          //           ),
          //         ),
          //       ),
          //     ),
          //     // Transform.scale(
          //     //   scale: 1,
          //     //   child: CupertinoSwitch(
          //     //     value: allRoom.power_all_projectors.getValue(),
          //     //     activeColor: AppColors.navy_blue,
          //     //     onChanged: (value) {
          //     //       setState(() {
          //     //         PowerAllProjectors();
          //     //       });
          //     //     },
          //     //   ),
          //     // ),
          //   ],
          // ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     PrimaryText(
          //       text: "Bật/tắt toàn bộ màn chập",
          //       color: AppColors.gray,
          //       size: 18,
          //       fontWeight: FontWeight.w500,
          //     ),
          //     Expanded(
          //       child: SizedBox(
          //         width: SizeConfig.blockSizeHorizontal,
          //       ),
          //     ),
          //     Container(
          //       height: 40,
          //       width: 60,
          //       child: ElevatedButton(
          //         style:ElevatedButton.styleFrom(
          //           backgroundColor: allRoom.shutter_all_projectors.getValue()? AppColors.navy_blue: AppColors.gray,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(20),
          //           ),
          //         ),
          //         onPressed: () {
          //           setState(() {
          //             ShutterAllProjectors(true);
          //           });
          //         },
          //         child: PrimaryText(text: 'On',
          //           size: 14,
          //           color: AppColors.white,
          //           fontWeight: FontWeight.w500,),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.fromLTRB(35,0,15,0),
          //       child: Container(
          //         height: 40,
          //         width: 60,
          //         child: Hero(
          //           tag: heroOffShutter,
          //           createRectTween: (begin, end) {
          //             return CustomRectTween(begin: begin, end: end);
          //           },
          //           child: ElevatedButton(
          //             style:ElevatedButton.styleFrom(
          //               backgroundColor: !allRoom.shutter_all_projectors.getValue()? AppColors.red: AppColors.gray,
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(20),
          //               ),
          //             ),
          //             onPressed: () {
          //               setState(() {
          //                 Navigator.of(context).push(HeroDialogRoute(builder: (context) {
          //                   return PopupOffShutter( onUpdateState: () {
          //                     setState(() {});
          //                   },);
          //                 }));
          //                 // ShutterAllProjectors(true);
          //               });
          //             },
          //             child: PrimaryText(text: 'Off',
          //               size: 14,
          //               color: AppColors.white,
          //               fontWeight: FontWeight.w500,),
          //           ),
          //         ),
          //       ),
          //     ),
          //     // Transform.scale(
          //     //   scale: 1,
          //     //   child: CupertinoSwitch(
          //     //   value: allRoom.shutter_all_projectors.getValue(),
          //     //   activeColor: AppColors.navy_blue,
          //     //   onChanged: (value) {
          //     //       setState(() {
          //     //         ShutterAllProjectors();
          //     //       });
          //     //     },
          //     //   ),
          //     // ),
          //   ],
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 100.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      spacing: 30,
                      runSpacing: 50,
                      children: [
                        Container(
                          // margin: const EdgeInsets.all(10.0),
                          // alignment: Alignment.center,
                          width: 135,
                          height: 135,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.navy_blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                PowerAllProjectors(true);
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/Icon/switch.png',
                                    height: 60,
                                  ),
                                ),
                                PrimaryText(
                                  text: 'All Power On',
                                  size: 14,
                                  color: AppColors.gray,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          // margin: const EdgeInsets.all(10.0),
                          // alignment: Alignment.center,
                          width: 135,
                          height: 135,
                          child: Hero(
                            tag: heroOffProjector,
                            createRectTween: (begin, end) {
                              return CustomRectTween(begin: begin, end: end);
                            },
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  Navigator.of(context)
                                      .push(HeroDialogRoute(builder: (context) {
                                    return PopupOffProjector(
                                      onUpdateState: () {
                                        setState(() {});
                                      },
                                    );
                                  }));
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/Icon/switch.png',
                                      height: 60,
                                    ),
                                  ),
                                  PrimaryText(
                                    text: 'All Power Off',
                                    size: 14,
                                    color: AppColors.gray,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 60.0),
                          // alignment: Alignment.center,
                          width: 135,
                          height: 135,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.navy_blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                ShutterAllProjectors(true);
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/Icon/shutter.png',
                                    height: 60,
                                  ),
                                ),
                                PrimaryText(
                                  text: 'All Shutter On',
                                  size: 14,
                                  color: AppColors.gray,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          // margin: const EdgeInsets.all(10.0),
                          // alignment: Alignment.center,
                          width: 135,
                          height: 135,
                          child: Hero(
                            tag: heroOffShutter,
                            createRectTween: (begin, end) {
                              return CustomRectTween(begin: begin, end: end);
                            },
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  Navigator.of(context)
                                      .push(HeroDialogRoute(builder: (context) {
                                    return PopupOffShutter(
                                      onUpdateState: () {
                                        setState(() {});
                                      },
                                    );
                                  }));
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/Icon/shutter.png',
                                      height: 60,
                                    ),
                                  ),
                                  PrimaryText(
                                    text: 'All Shutter Off',
                                    size: 14,
                                    color: AppColors.gray,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Wrap(
                          direction: Axis.vertical,
                          spacing: 15,
                          children: [
                            Container(
                              width: 135,
                              height: 50,
                              // alignment: Alignment.center,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.yellow1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    LampMode(0);
                                    // PowerOnAllServer();
                                  });
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Image.asset('assets/Icon/shutter.png', height: 60,),
                                    // ),
                                    PrimaryText(
                                      text: 'All Lamp On',
                                      size: 14,
                                      color: AppColors.gray,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 135,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.yellow2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    LampMode(1);
                                  });
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Image.asset('assets/Icon/shutter.png', height: 60,),
                                    // ),
                                    PrimaryText(
                                      text: 'A1   A2   A3',
                                      size: 14,
                                      color: AppColors.gray,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 135,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.yellow2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    LampMode(2);
                                    // PowerOnAllServer();
                                  });
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Image.asset('assets/Icon/shutter.png', height: 60,),
                                    // ),
                                    PrimaryText(
                                      text: 'B1   B2   B3',
                                      size: 14,
                                      color: AppColors.gray,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 70,
                        ),
                        Wrap(
                          direction: Axis.vertical,
                          spacing: 10,
                          children: [
                            Wrap(
                              spacing: 50,
                              runSpacing: 50,
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                      allRoom.A1.getValue()
                                          ? 'assets/Icon/light-bulb-3.png'
                                          : 'assets/Icon/light-bulb-bw-2.png',
                                      height: 60,
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical,
                                    ),
                                    PrimaryText(
                                      text: 'A1',
                                      size: 14,
                                      color: AppColors.white,
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      allRoom.A2.getValue()
                                          ? 'assets/Icon/light-bulb-3.png'
                                          : 'assets/Icon/light-bulb-bw-2.png',
                                      height: 60,
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical,
                                    ),
                                    PrimaryText(
                                      text: 'A2',
                                      size: 14,
                                      color: AppColors.white,
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      allRoom.A3.getValue()
                                          ? 'assets/Icon/light-bulb-3.png'
                                          : 'assets/Icon/light-bulb-bw-2.png',
                                      height: 60,
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical,
                                    ),
                                    PrimaryText(
                                      text: 'A3',
                                      size: 14,
                                      color: AppColors.white,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Wrap(
                              spacing: 50,
                              runSpacing: 50,
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                      allRoom.B1.getValue()
                                          ? 'assets/Icon/light-bulb-3.png'
                                          : 'assets/Icon/light-bulb-bw-2.png',
                                      height: 60,
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical,
                                    ),
                                    PrimaryText(
                                      text: 'B1',
                                      size: 14,
                                      color: AppColors.white,
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      allRoom.B2.getValue()
                                          ? 'assets/Icon/light-bulb-3.png'
                                          : 'assets/Icon/light-bulb-bw-2.png',
                                      height: 60,
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical,
                                    ),
                                    PrimaryText(
                                      text: 'B2',
                                      size: 14,
                                      color: AppColors.white,
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      allRoom.B3.getValue()
                                          ? 'assets/Icon/light-bulb-3.png'
                                          : 'assets/Icon/light-bulb-bw-2.png',
                                      height: 60,
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical,
                                    ),
                                    PrimaryText(
                                      text: 'B3',
                                      size: 14,
                                      color: AppColors.white,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 70,
                        ),
                        Wrap(
                          direction: Axis.vertical,
                          spacing: 15,
                          children: [
                            Container(
                              width: 135,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.yellow3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    LampMode(3);
                                    // PowerOnAllServer();
                                  });
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Image.asset('assets/Icon/shutter.png', height: 60,),
                                    // ),
                                    PrimaryText(
                                      text: 'A1   B1',
                                      size: 14,
                                      color: AppColors.gray,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 135,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.yellow3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    LampMode(4);
                                    // PowerOnAllServer();
                                  });
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Image.asset('assets/Icon/shutter.png', height: 60,),
                                    // ),
                                    PrimaryText(
                                      text: 'A2   B2',
                                      size: 14,
                                      color: AppColors.gray,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 135,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.yellow3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    LampMode(5);
                                    // PowerOnAllServer();
                                  });
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Image.asset('assets/Icon/shutter.png', height: 60,),
                                    // ),
                                    PrimaryText(
                                      text: 'A3   B3',
                                      size: 14,
                                      color: AppColors.gray,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                  ],
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 4,
                ),
                Column(
                  children: [
                    Container(
                      width: 250,
                      height: 100,
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(),
                          ),
                          PrimaryText(
                            text: "Electronic",
                            size: 16,
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 2,
                          ),
                          Transform.scale(
                            scale: 1.5,
                            child: CupertinoSwitch(
                              value: allRoom.electronic_mode.getValue(),
                              activeColor: AppColors.green,
                              onChanged: (value) {
                                setState(() {
                                  ElectronicMode(value);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 250,
                      height: 100,
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(),
                          ),
                          PrimaryText(
                            text: "ADS",
                            size: 16,
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 2,
                          ),
                          Transform.scale(
                            scale: 1.5,
                            child: CupertinoSwitch(
                              value: allRoom.ASD_mode.getValue(),
                              activeColor: AppColors.green,
                              onChanged: (value) {
                                setState(() {
                                  ADSMode(value);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 250,
                      height: 100,
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(),
                          ),
                          PrimaryText(
                            text: "OSD",
                            size: 16,
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 2,
                          ),
                          Transform.scale(
                            scale: 1.5,
                            child: CupertinoSwitch(
                              value: allRoom.OSD_mode.getValue(),
                              activeColor: AppColors.green,
                              onChanged: (value) {
                                setState(() {
                                  OSDMode((value));
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 250,
                      height: 100,
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(),
                          ),
                          PrimaryText(
                            text: "White/Green",
                            size: 16,
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 2,
                          ),
                          Transform.scale(
                            scale: 1.5,
                            child: CupertinoSwitch(
                              value: allRoom.whiteOrGreen.getValue(),
                              activeColor: AppColors.green,
                              onChanged: (value) {
                                setState(() {
                                  WhiteOrGreenMode(value);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
