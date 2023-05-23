import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_dashboard/Method/Control_all_room_void.dart';
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
      height: Responsive.isDesktop(context)? 180:null,
      constraints: BoxConstraints(minWidth: Responsive.isDesktop(context) ? 300 : SizeConfig.screenWidth - 40,
                                  maxWidth: Responsive.isDesktop(context) ? SizeConfig.screenWidth/2-150: SizeConfig.screenWidth- 40),
        padding: EdgeInsets.only(
            top: 20, bottom: 20, left: 20, right: Responsive.isMobile(context) ? 20 : 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.barBg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset('assets/small_projector.png', height: 30,),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal,
                ),
                PrimaryText(
                  text: 'Quản lý máy chiếu',
                  color: AppColors.gray,
                  size: 20,
                  fontWeight: FontWeight.w600,
                ),
                Expanded(
                  child: SizedBox(
                    width: SizeConfig.blockSizeHorizontal,
                  ),
                ),
                PrimaryText(
                text: 'num',//projectors.length.toString(),
                color: AppColors.iconDeepGray,
                size: 16
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PrimaryText(
                  text: "Bật/tắt toàn bộ máy chiếu",
                  color: AppColors.gray,
                  size: 18,
                  fontWeight: FontWeight.w500,
                ),
                Expanded(
                  child: SizedBox(
                    width: SizeConfig.blockSizeHorizontal,
                  ),
                ),
                Container(
                  height: 40,
                  width: 60,
                  child: ElevatedButton(
                    style:ElevatedButton.styleFrom(
                      backgroundColor: allRoom.power_all_projectors.getValue()? AppColors.navy_blue: AppColors.gray,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        PowerAllProjectors(true);
                      });
                    },
                    child: PrimaryText(text: 'On',
                      size: 14,
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35,0,15,0),
                  child: Container(
                    height: 40,
                    width: 60,
                    child: Hero(
                      tag: heroOffProjector,
                      createRectTween: (begin, end) {
                        return CustomRectTween(begin: begin, end: end);
                      },
                      child: ElevatedButton(
                        style:ElevatedButton.styleFrom(
                          backgroundColor: !allRoom.power_all_projectors.getValue()? AppColors.red: AppColors.gray,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                              return const PopupOffProjector();
                            }));
                            // PowerAllProjectors(false);
                          });
                        },
                        child: PrimaryText(text: 'Off',
                          size: 14,
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,),
                      ),
                    ),
                  ),
                ),
                // Transform.scale(
                //   scale: 1,
                //   child: CupertinoSwitch(
                //     value: allRoom.power_all_projectors.getValue(),
                //     activeColor: AppColors.navy_blue,
                //     onChanged: (value) {
                //       setState(() {
                //         PowerAllProjectors();
                //       });
                //     },
                //   ),
                // ),
              ],
            ),
            // PrimaryText(
            //     text: 'Phòng 2 đã bật '+ allRoom.num_projectors_connected.getValue().toString() +'/' + allRoom.num_projectors.getValue().toString(),
            //     color: AppColors.iconDeepGray,
            //     size: 16),
            // PrimaryText(
            //     text: 'Phòng 4 đã bật '+ allRoom.num_projectors_connected.getValue().toString() +'/' + allRoom.num_projectors.getValue().toString(),
            //     color: AppColors.iconDeepGray,
            //     size: 16),
            // PrimaryText(
            //     text: 'Phòng 5 đã bật '+ allRoom.num_projectors_connected.getValue().toString() +'/' + allRoom.num_projectors.getValue().toString(),
            //     color: AppColors.iconDeepGray,
            //     size: 16),
            // PrimaryText(
            //     text: 'Phòng 6 đã bật '+ allRoom.num_projectors_connected.getValue().toString() +'/' + allRoom.num_projectors.getValue().toString(),
            //     color: AppColors.iconDeepGray,
            //     size: 16),
            SizedBox(
              height: SizeConfig.blockSizeVertical*2,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PrimaryText(
                  text: "Bật/tắt toàn bộ màn chập",
                  color: AppColors.gray,
                  size: 18,
                  fontWeight: FontWeight.w500,
                ),
                Expanded(
                  child: SizedBox(
                    width: SizeConfig.blockSizeHorizontal,
                  ),
                ),
                Container(
                  height: 40,
                  width: 60,
                  child: ElevatedButton(
                    style:ElevatedButton.styleFrom(
                      backgroundColor: allRoom.shutter_all_projectors.getValue()? AppColors.navy_blue: AppColors.gray,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        ShutterAllProjectors(true);
                      });
                    },
                    child: PrimaryText(text: 'On',
                      size: 14,
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35,0,15,0),
                  child: Container(
                    height: 40,
                    width: 60,
                    child: Hero(
                      tag: heroOffShutter,
                      createRectTween: (begin, end) {
                        return CustomRectTween(begin: begin, end: end);
                      },
                      child: ElevatedButton(
                        style:ElevatedButton.styleFrom(
                          backgroundColor: !allRoom.shutter_all_projectors.getValue()? AppColors.red: AppColors.gray,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                              return const PopupOffShutter();
                            }));
                            // ShutterAllProjectors(false);
                          });
                        },
                        child: PrimaryText(text: 'Off',
                          size: 14,
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,),
                      ),
                    ),
                  ),
                ),
                // Transform.scale(
                //   scale: 1,
                //   child: CupertinoSwitch(
                //   value: allRoom.shutter_all_projectors.getValue(),
                //   activeColor: AppColors.navy_blue,
                //   onChanged: (value) {
                //       setState(() {
                //         ShutterAllProjectors();
                //       });
                //     },
                //   ),
                // ),
              ],
            ),
            // PrimaryText(
            //     text: 'Phòng 2 đã bật '+ allRoom.num_projectors_connected.getValue().toString() +'/' + allRoom.num_projectors.getValue().toString(),
            //     color: AppColors.iconDeepGray,
            //     size: 16),
            // PrimaryText(
            //     text: 'Phòng 4 đã bật '+ allRoom.num_projectors_connected.getValue().toString() +'/' + allRoom.num_projectors.getValue().toString(),
            //     color: AppColors.iconDeepGray,
            //     size: 16),
            // PrimaryText(
            //     text: 'Phòng 5 đã bật '+ allRoom.num_projectors_connected.getValue().toString() +'/' + allRoom.num_projectors.getValue().toString(),
            //     color: AppColors.iconDeepGray,
            //     size: 16),
            // PrimaryText(
            //     text: 'Phòng 6 đã bật '+ allRoom.num_projectors_connected.getValue().toString() +'/' + allRoom.num_projectors.getValue().toString(),
            //     color: AppColors.iconDeepGray,
            //     size: 16),
          ],
        ),);
  }
}