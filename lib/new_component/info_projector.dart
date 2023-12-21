import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_dashboard/Method/Control_projector_void.dart';
import 'package:responsive_dashboard/Method/projector_command.dart';
import 'package:responsive_dashboard/Method/projector_void.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

class InfoProjector extends StatefulWidget {
  Projector projector;

  InfoProjector({
    required this.projector,
  });

  @override
  _InfoProjector createState() => _InfoProjector();
}

// class _MainPageState extends State<MainPage> {
//   bool value = true;

class _InfoProjector extends State<InfoProjector> {


  // void MuteVideoProjector() {
  //   projector.mute_video.setValue(!projector.mute_video.getValue());
  //   print(projector.ip + " " +projector.port.toString() +" MUTE_Video " +projector.shutter_status.getValue().toString());
  // }
  //
  // void MuteAudioProjector() {
  //   projector.mute_audio.setValue(!projector.mute_audio.getValue());
  //   print(projector.ip + " " +projector.port.toString() +" MUTE_Audio " +projector.shutter_status.getValue().toString());
  // }

  @override
  Widget build(BuildContext context) {
    Projector projector = widget.projector;
    return Container(
      constraints: BoxConstraints(
          minWidth: Responsive.isDesktop(context)
              ? 280
              : SizeConfig.screenWidth / 2 - 75,
          maxWidth: Responsive.isDesktop(context)
              ? SizeConfig.screenWidth / 3 - 110
              : SizeConfig.screenWidth / 2 - 45),
      padding: EdgeInsets.only(
          top: 20,
          bottom: 20,
          left: 20,
          right: Responsive.isMobile(context) ? 20 : 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/credit-card.svg', width: 35),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal,
              ),
              PrimaryText(
                text: projector.name,
                size: 18,
                fontWeight: FontWeight.w700,
              ),
              Expanded(
                child: SizedBox(
                  width: SizeConfig.blockSizeHorizontal,
                ),
              ),
              PrimaryText(
                  text: projector.ip, color: AppColors.secondary, size: 14)
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PrimaryText(
                text: "Bật/Tắt máy chiếu",
                size: 17,
                fontWeight: FontWeight.w500,
              ),
              Expanded(
                child: SizedBox(
                  width: SizeConfig.blockSizeHorizontal,
                ),
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal,
              ),

              Container(
                height: 40,
                width: 70,
                child: ElevatedButton(
                  style:ElevatedButton.styleFrom(
                    backgroundColor: AppColors.PowerOnButtonColor[projector.status.getValue()],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      PowerModeProjector(projector, true);
                    });
                  },
                  child: PrimaryText(text: 'On',
                    size: 14,
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15,0,0,0),
                child: Container(
                  height: 40,
                  width: 70,
                  child: ElevatedButton(
                    style:ElevatedButton.styleFrom(
                      backgroundColor: AppColors.PowerOffButtonColor[projector.status.getValue()],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        PowerModeProjector(projector, false);
                      });
                    },
                    child: PrimaryText(text: 'Off',
                      size: 14,
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical,
          ),
          Row(
            children: [
              PrimaryText(
                  text: Power_Status[projector.status.getValue()],
                  color: AppColors.StatusColor[projector.status.getValue()],
                  size: 16),
              // Expanded(
              //   child: SizedBox(
              //     width: SizeConfig.blockSizeHorizontal,
              //   ),
              // ),
              // GestureDetector(
              //   onTap: (){
              //     setState(() {
              //       PowerStatus(projector);
              //     });
              //   },
              //   child: PrimaryText(
              //       text: 'Kiểm tra',
              //       color: AppColors.navy_blue2,
              //       size: 14,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PrimaryText(
                text: "Bật/Tắt màn chập",
                size: 17,
                fontWeight: FontWeight.w500,
              ),
              Expanded(
                child: SizedBox(
                  width: SizeConfig.blockSizeHorizontal,
                ),
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal,
              ),
              Container(
                height: 40,
                width: 70,
                child: ElevatedButton(
                  style:ElevatedButton.styleFrom(
                    backgroundColor:AppColors.ShutterOnButtonColor[projector.status.getValue()],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      ShutterModeProjector(projector, true);
                    });
                  },
                  child: PrimaryText(text: 'On',
                    size: 14,
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15,0,0,0),
                child: Container(
                  height: 40,
                  width: 70,
                  child: ElevatedButton(
                    style:ElevatedButton.styleFrom(
                      backgroundColor: AppColors.ShutterOffButtonColor[projector.status.getValue()],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        ShutterModeProjector(projector, false);
                      });
                    },
                    child: PrimaryText(text: 'Off',
                      size: 14,
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical,
          ),
          Row(
            children: [
              PrimaryText(
                  text: Shutter_Status[projector.status.getValue()],
                  color: AppColors.StatusColor[projector.status.getValue()],
                  size: 16),
              // Expanded(
              //   child: SizedBox(
              //     width: SizeConfig.blockSizeHorizontal,
              //   ),
              // ),
              // GestureDetector(
              //   onTap: (){
              //     setState(() {
              //       ShutterStatus(projector);
              //     });
              //   },
              //   child: PrimaryText(
              //     text: 'Kiểm tra',
              //     color: AppColors.navy_blue2,
              //     size: 14,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
            ],
          ),
          SizedBox(height: SizeConfig.blockSizeVertical,),
          // Row(
          //   children: [
          //     PrimaryText(
          //       text: "Số giờ bóng: ${projector.lamp_hours.getValue().toStringAsFixed(1)}",
          //       size: 17,
          //       fontWeight: FontWeight.w500,
          //     ),
          //     Expanded(
          //       child: SizedBox(
          //         width: SizeConfig.blockSizeHorizontal,
          //       ),
          //     ),
          //     GestureDetector(
          //       onTap: (){
          //         setState(() {
          //           LampStatus(projector);
          //         });
          //       },
          //       child: PrimaryText(
          //         text: 'Kiểm tra',
          //         color: AppColors.navy_blue2,
          //         size: 14,
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //   ],
          // ),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     PrimaryText(
          //       text: "Mute video",
          //       size: 17,
          //       fontWeight: FontWeight.w500,
          //     ),
          //     Expanded(
          //       child: SizedBox(
          //         width: SizeConfig.blockSizeHorizontal,
          //       ),
          //     ),
          //     PrimaryText(
          //         text: projector.mute_video.getValue().toString(),
          //         color: AppColors.secondary,
          //         size: 14),
          //     SizedBox(
          //       width: SizeConfig.blockSizeHorizontal,
          //     ),
          //     Transform.scale(
          //       scale: 1,
          //       child: CupertinoSwitch(
          //         value: projector.mute_video.getValue(),
          //         onChanged: (value) {
          //           setState(() {
          //             MuteVideoProjector();
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
          //       size: 17,
          //       fontWeight: FontWeight.w500,
          //     ),
          //     Expanded(
          //       child: SizedBox(
          //         width: SizeConfig.blockSizeHorizontal,
          //       ),
          //     ),
          //     PrimaryText(
          //         text: projector.mute_audio.getValue().toString(),
          //         color: AppColors.secondary,
          //         size: 14),
          //     SizedBox(
          //       width: SizeConfig.blockSizeHorizontal,
          //     ),
          //     Transform.scale(
          //       scale: 1,
          //       child: CupertinoSwitch(
          //         value: projector.mute_audio.getValue(),
          //         onChanged: (value) {
          //           setState(() {
          //             MuteAudioProjector();
          //           });
          //         },
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
