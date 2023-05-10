import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_dashboard/Method/projector_cmd.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/data/global_value.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

List<Projector> projectors = rooms[0].projectors;

class ProjectorsManager extends StatefulWidget {
  @override
  _ProjectorsManager createState() => _ProjectorsManager();
}

class _ProjectorsManager extends State<ProjectorsManager> {

  void PowerAllProjectors() {
    setState(() {
      power_all.setValue(!power_all.getValue());
      for (var projector in projectors) {
        if (projector.power_status.getValue() != power_all.getValue()) {
          power_all.getValue()? print(projector.ip.toString() + '(PWR 1)'): print(projector.ip.toString() + '(PWR 0)');
          power_all.getValue()? sendPJLinkCommand(projector.ip,projector.port, '(PWR 1)') : sendPJLinkCommand(projector.ip,projector.port, '(PWR 0)');
        }
        projector.power_status.setValue(power_all.getValue());
      }
    });
  }
  void ShutterAllProjectors() {
    setState(() {
      shutter_all.setValue(!shutter_all.getValue());
      for (var projector in projectors) {
        if (projector.shutter_status.getValue() != shutter_all.getValue()) {
          shutter_all.getValue()? print(projector.ip.toString() + '(SHU 1)'): print(projector.ip.toString() + '(SHU 0)');
          shutter_all.getValue()? sendPJLinkCommand(projector.ip,projector.port, '(SHU 1)') : sendPJLinkCommand(projector.ip,projector.port, '(SHU 0)');
        }
        projector.shutter_status.setValue(shutter_all.getValue());
      }
    });
  }
  // void MuteVideoAllProjectors() {
  //   setState(() {
  //     mute_video_all.setValue(!mute_video_all.getValue());
  //     for (var projector in projectors) {
  //       projector.connected.setValue(mute_video_all.getValue());
  //     }
  //   });
  // }
  // void MuteAudioAllProjectors() {
  //   setState(() {
  //     mute_audio_all.setValue(!mute_audio_all.getValue());
  //     for (var projector in projectors) {
  //       projector.mute_audio.setValue(mute_audio_all.getValue());
  //     }
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: Responsive.isDesktop(context) ? 600 : SizeConfig.screenWidth - 40,
                                  maxWidth: Responsive.isDesktop(context) ? SizeConfig.screenWidth-40 : SizeConfig.screenWidth- 40),
        padding: EdgeInsets.only(
            top: 20, bottom: 20, left: 20, right: Responsive.isMobile(context) ? 20 : 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.primary,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset('assets/credit-card.svg', width: 35, color: AppColors.white),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal,
                ),
                PrimaryText(
                  text: 'Tổng số máy chiếu',
                  color: AppColors.white,
                  size: 18,
                  fontWeight: FontWeight.w700,
                ),
                Expanded(
                  child: SizedBox(
                    width: SizeConfig.blockSizeHorizontal,
                  ),
                ),
                PrimaryText(
                text: projectors.length.toString(),
                color: AppColors.secondary,
                size: 16
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PrimaryText(
                  text: "Power mode",
                  color: AppColors.white,
                  size: 18,
                  fontWeight: FontWeight.w500,
                ),
                Expanded(
                  child: SizedBox(
                    width: SizeConfig.blockSizeHorizontal,
                  ),
                ),
                PrimaryText(
                    text: power_all.getValue().toString(),
                    color: AppColors.secondary,
                    size: 16),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal,
                ),
                Transform.scale(
                  scale: 1,
                  child: CupertinoSwitch(
                    value: power_all.getValue(),
                    onChanged: (value) {
                      setState(() {
                        PowerAllProjectors();
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PrimaryText(
                  text: "Shutter mode",
                  color: AppColors.white,
                  size: 18,
                  fontWeight: FontWeight.w500,
                ),
                Expanded(
                  child: SizedBox(
                    width: SizeConfig.blockSizeHorizontal,
                  ),
                ),
                PrimaryText(
                    text:shutter_all.getValue().toString(),
                    color: AppColors.secondary,
                    size: 16),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal,
                ),
                Transform.scale(
                  scale: 1,
                  child: CupertinoSwitch(
                  value: shutter_all.getValue(),
                  onChanged: (value) {
                      setState(() {
                        ShutterAllProjectors();
                      });
                    },
                  ),
                ),
              ],
            ),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     PrimaryText(
            //       text: "Mute video",
            //       color: AppColors.white,
            //       size: 18,
            //       fontWeight: FontWeight.w500,
            //     ),
            //     Expanded(
            //       child: SizedBox(
            //         width: SizeConfig.blockSizeHorizontal,
            //       ),
            //     ),
            //     PrimaryText(
            //         text: mute_video_all.getValue().toString(),
            //         color: AppColors.secondary,
            //         size: 16),
            //     SizedBox(
            //       width: SizeConfig.blockSizeHorizontal,
            //     ),
            //     Transform.scale(
            //       scale: 1,
            //       child: CupertinoSwitch(
            //         value: mute_video_all.getValue(),
            //         onChanged: (value) {
            //           setState(() {
            //             MuteVideoAllProjectors();
            //           });
            //         },
            //       ),
            //     ),
            //   ],
            // ),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     PrimaryText(
            //       text: "Mute audio",
            //       color: AppColors.white,
            //       size: 18,
            //       fontWeight: FontWeight.w500,
            //     ),
            //     Expanded(
            //       child: SizedBox(
            //         width: SizeConfig.blockSizeHorizontal,
            //       ),
            //     ),
            //     PrimaryText(
            //         text: mute_audio_all.getValue().toString(),
            //         color: AppColors.secondary,
            //         size: 16),
            //     SizedBox(
            //       width: SizeConfig.blockSizeHorizontal,
            //     ),
            //     Transform.scale(
            //       scale: 1,
            //       child: CupertinoSwitch(
            //         value: mute_audio_all.getValue(),
            //         onChanged: (value) {
            //           setState(() {
            //             MuteAudioAllProjectors();
            //             // print(projector[0].ip.toString()+" "+projector[0].port.toString()+"PWR "+projector[0].mute_audio.toString());
            //             // mute_audio_all = !mute_audio_all;
            //           });
            //         },
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),);
  }
}