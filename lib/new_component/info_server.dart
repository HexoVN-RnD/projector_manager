import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_dashboard/Method/ping_check_connection.dart';
import 'package:responsive_dashboard/Method/projector_command.dart';
import 'package:responsive_dashboard/Method/server_void.dart';
import 'package:responsive_dashboard/Method/udp_void.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

class InfoServer extends StatefulWidget {
  Room room;
  Server server;

  InfoServer({
    required this.room,
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
    Room room = widget.room;
    Server server = widget.server;
    return Container(
      constraints: BoxConstraints(
          minWidth: room.servers.length>1
              ? 300
              : SizeConfig.screenWidth / 2 - 75,
          maxWidth: room.servers.length>1
              ? SizeConfig.screenWidth / 3 - 110
              : SizeConfig.screenWidth / 3*2 - 45),
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
              Container(
                height: 40,
                width: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: server.power_status.getValue()
                        ? AppColors.navy_blue
                        : AppColors.gray,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      WakeonLan(room,server);
                    });
                  },
                  child: PrimaryText(
                    text: 'On',
                    size: 14,
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Container(
                  height: 40,
                  width: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: server.power_status.getValue()
                          ? AppColors.gray
                          : AppColors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        ShutdownServer(room,server);
                      });
                    },
                    child: PrimaryText(
                      text: 'Off',
                      size: 14,
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              // Transform.scale(
              //   scale: 1,
              //   child: CupertinoSwitch(
              //     value: server.power_status.getValue(),
              //     activeColor: AppColors.navy_blue,
              //     onChanged: (value) {
              //       setState(() {
              //         PowerModeServer(server);
              //       });
              //     },
              //   ),
              // ),
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical,
          ),
          Row(
            children: [
              PrimaryText(
                  text: server.connected.getValue()
                      ? (server.power_status.getValue()
                          ? 'Đã bật server'
                          : 'Đang tắt server ...')
                      : (server.power_status.getValue()
                          ? 'Đang bật server ...'
                          : 'Đã tắt server'),
                  color: AppColors.secondary,
                  size: 16),
              // Expanded(
              //   child: SizedBox(
              //     width: SizeConfig.blockSizeHorizontal,
              //   ),
              // ),
              // GestureDetector(
              //   onTap: () {
              //     setState(() {
              //       checkConnectionServer(server);
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
