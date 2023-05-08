import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_dashboard/Method/projector_cmd.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

class InfoServer extends StatefulWidget {
  Server server;

  InfoServer({
    @required this.server,
  });

  @override
  _InfoServer createState() => _InfoServer(this.server);
}

// class _MainPageState extends State<MainPage> {
//   bool value = true;

class _InfoServer extends State<InfoServer> {
  Server server;
  _InfoServer(this.server);

  void PowerModeProjector() {
    // server.power_status.getValue()? sendPJLinkCommand(server.ip,server.port, '(PWR 0)'): sendPJLinkCommand(server.ip,server.port, '(PWR 1)');
    server.power_status.setValue(!server.power_status.getValue());
    print(server.ip + " " +server.port.toString() +" PWR " +server.power_status.getValue().toString());
  }

  // void ShutterModeProjector() {
  //   server.shutter_status.getValue()? sendPJLinkCommand(server.ip,server.port, '(SHU 0)'): sendPJLinkCommand(server.ip,server.port, '(SHU 1)');
  //   server.shutter_status.setValue(!server.shutter_status.getValue());
  //   print(server.ip + " " +server.port.toString() +" SHU " +server.shutter_status.getValue().toString());
  // }

  // void MuteVideoProjector() {
  //   projector.mute_video.setValue(!projector.mute_video.getValue());
  //   print(projector.ip + " " +projector.port.toString() +" MUTE_Video " +projector.shutter_status.getValue().toString());
  // }
  //
  void MuteAudioProjector() {
    server.mute_audio.setValue(!server.mute_audio.getValue());
    print(server.ip + " " +server.port.toString() +" MUTE_Audio " +server.mute_audio.getValue().toString());
  }

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
                text: server.name,
                size: 18,
                fontWeight: FontWeight.w700,
              ),
              Expanded(
                child: SizedBox(
                  width: SizeConfig.blockSizeHorizontal,
                ),
              ),
              PrimaryText(
                  text: server.ip,
                  color: AppColors.secondary,
                  size: 16)
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PrimaryText(
                text: "Bật/Tắt server",
                size: 18,
                fontWeight: FontWeight.w500,
              ),
              Expanded(
                child: SizedBox(
                  width: SizeConfig.blockSizeHorizontal,
                ),
              ),
              PrimaryText(
                  text: server.power_status.getValue().toString(),
                  color: AppColors.secondary,
                  size: 16),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal,
              ),
              Transform.scale(
                scale: 1,
                child: CupertinoSwitch(
                  value: server.power_status.getValue(),
                  activeColor: AppColors.navy_blue,
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
                text: "Bật/Tắt âm thanh",
                size: 18,
                fontWeight: FontWeight.w500,
              ),
              Expanded(
                child: SizedBox(
                  width: SizeConfig.blockSizeHorizontal,
                ),
              ),
              PrimaryText(
                  text: server.mute_audio.getValue().toString(),
                  color: AppColors.secondary,
                  size: 16),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal,
              ),
              Transform.scale(
                scale: 1,
                child: CupertinoSwitch(
                  value: server.mute_audio.getValue(),
                  onChanged: (value) {
                    setState(() {
                      MuteAudioProjector();
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
