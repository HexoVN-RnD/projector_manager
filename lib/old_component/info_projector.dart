import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_dashboard/Method/projector_cmd.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

class InfoProjector extends StatefulWidget {
  Projector projector;

  InfoProjector({
    @required this.projector,
  });

  @override
  _InfoProjector createState() => _InfoProjector(this.projector);
}

// class _MainPageState extends State<MainPage> {
//   bool value = true;

class _InfoProjector extends State<InfoProjector> {
  Projector projector;
  _InfoProjector(this.projector);

  void PowerModeProjector() {
    projector.power_status.getValue()? sendPJLinkCommand(projector.ip,projector.port, '(PWR 0)'): sendPJLinkCommand(projector.ip,projector.port, '(PWR 1)');
    projector.power_status.setValue(!projector.power_status.getValue());
    print(projector.ip + " " +projector.port.toString() +" PWR " +projector.power_status.getValue().toString());
  }

  void ShutterModeProjector() {
    projector.shutter_status.getValue()? sendPJLinkCommand(projector.ip,projector.port, '(SHU 0)'): sendPJLinkCommand(projector.ip,projector.port, '(SHU 1)');
    projector.shutter_status.setValue(!projector.shutter_status.getValue());
    print(projector.ip + " " +projector.port.toString() +" SHU " +projector.shutter_status.getValue().toString());
  }

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
    return Container(
      constraints: BoxConstraints(
          minWidth: Responsive.isDesktop(context)
              ? 300
              : SizeConfig.screenWidth / 2 - 40,
          maxWidth: Responsive.isDesktop(context)
              ? SizeConfig.screenWidth / 3 - 40
              : SizeConfig.screenWidth / 2 - 40),
      padding: EdgeInsets.only(
          top: 20,
          bottom: 20,
          left: 20,
          right: Responsive.isMobile(context) ? 20 : 40),
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
                  text: projector.ip,
                  color: AppColors.secondary,
                  size: 16)
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PrimaryText(
                text: "Bật/Tắt máy chiếu",
                size: 18,
                fontWeight: FontWeight.w500,
              ),
              Expanded(
                child: SizedBox(
                  width: SizeConfig.blockSizeHorizontal,
                ),
              ),
              PrimaryText(
                  text: projector.power_status.getValue().toString(),
                  color: AppColors.secondary,
                  size: 16),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal,
              ),
              Transform.scale(
                scale: 1,
                child: CupertinoSwitch(
                  value: projector.power_status.getValue(),
                  onChanged: (value) {
                    setState(() {
                      PowerModeProjector();
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
                text: "Bật/Tắt màn chập",
                size: 18,
                fontWeight: FontWeight.w500,
              ),
              Expanded(
                child: SizedBox(
                  width: SizeConfig.blockSizeHorizontal,
                ),
              ),
              PrimaryText(
                  text: projector.shutter_status.getValue().toString(),
                  color: AppColors.secondary,
                  size: 16),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal,
              ),
              Transform.scale(
                scale: 1,
                child: CupertinoSwitch(
                  value: projector.shutter_status.getValue(),
                  onChanged: (value) {
                    setState(() {
                      ShutterModeProjector();
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
          //       size: 18,
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
          //         size: 16),
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
          //       size: 18,
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
          //         size: 16),
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
