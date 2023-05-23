import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_dashboard/Method/ping_check_connection.dart';
import 'package:responsive_dashboard/Method/projector_command.dart';
import 'package:responsive_dashboard/Method/server_void.dart';
import 'package:responsive_dashboard/Method/udp_void.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

class InfoServer extends StatefulWidget {
  Server server;

  InfoServer({
    required this.server,
  });

  @override
  _InfoServer createState() => _InfoServer();
}

// class _MainPageState extends State<MainPage> {
//   bool value = true;

class _InfoServer extends State<InfoServer> {

  @override
  Widget build(BuildContext context) {
    Server server = widget.server;
    return Container(
      constraints: BoxConstraints(
          minWidth: Responsive.isDesktop(context)
              ? 300
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
                text: server.name,
                size: 18,
                fontWeight: FontWeight.w700,
              ),
              Expanded(
                child: SizedBox(
                  width: SizeConfig.blockSizeHorizontal,
                ),
              ),
              PrimaryText(text: server.ip, color: AppColors.secondary, size: 16)
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
                      PowerModeServer(server);
                    });
                  },
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
                  text: server.connected.getValue()? 'Đã bật': 'Đã tắt',
                  color: AppColors.secondary,
                  size: 14),
              Expanded(
                child: SizedBox(
                  width: SizeConfig.blockSizeHorizontal,
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    checkConnectionServer(server.ip, server.connected, server.power_status );
                  });
                },
                child: PrimaryText(
                  text: 'Kiểm tra',
                  color: AppColors.navy_blue2,
                  size: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     PrimaryText(
          //       text: "Âm thanh",
          //       size: 18,
          //       fontWeight: FontWeight.w500,
          //     ),
          //     Expanded(
          //       child: SizedBox(
          //         width: SizeConfig.blockSizeHorizontal,
          //       ),
          //     ),
          //     // PrimaryText(
          //     //     text: server.volume.getValue().toString(),
          //     //     color: AppColors.secondary,
          //     //     size: 16),
          //     // SizedBox(
          //     //   width: SizeConfig.blockSizeHorizontal,
          //     // ),
          //     Expanded(
          //       child: Transform.scale(
          //         scale: 1,
          //         child: Slider(
          //           activeColor: AppColors.navy_blue,
          //           inactiveColor: AppColors.light_navy_blue,
          //           value: server.volume.getValue(),
          //           onChanged: (index) {
          //             setState(() => ChangeVolume(server, index));
          //           },
          //           min: 0,
          //           max: 1,
          //           // divisions: 5,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // PrimaryText(
          //     text: (server.volume.getValue()*100).toStringAsFixed(0), //+'%',
          //     color: AppColors.secondary,
          //     size: 16),
        ],
      ),
    );
  }
}
