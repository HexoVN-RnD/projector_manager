import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_dashboard/Method/Control_all_projectors_void.dart';
import 'package:responsive_dashboard/Method/server_void.dart';
import 'package:responsive_dashboard/Object/allRoom.dart';
import 'package:responsive_dashboard/PopUp/HeroDialogRoute.dart';
import 'package:responsive_dashboard/PopUp/customRectTween.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/PopUp/PopupOffServer.dart';
import 'package:responsive_dashboard/new_component/AllServersStatus.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

class ManageAllServers extends StatefulWidget {
  @override
  _ManageAllServersState createState() => _ManageAllServersState();
}

class _ManageAllServersState extends State<ManageAllServers> {
  @override
  Widget build(BuildContext context) {
    AllRoom allRooms = allRoom;
    return Container(
      height: Responsive.isDesktop(context) ? 250 : null,
      constraints: BoxConstraints(
          minWidth:
              Responsive.isDesktop(context) ? 300 : SizeConfig.screenWidth - 40,
          maxWidth: Responsive.isDesktop(context)
              ? SizeConfig.screenWidth / 2 - 150
              : SizeConfig.screenWidth - 40),
      padding: EdgeInsets.only(
          top: 20,
          bottom: 20,
          left: 20,
          right: Responsive.isMobile(context) ? 20 : 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.barBg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.airplay,
                size: 30,
                color: AppColors.grey,
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal,
              ),
              PrimaryText(
                text: 'Quản lý servers',
                color: AppColors.grey,
                size: 20,
                fontWeight: FontWeight.w600,
              ),
              // Expanded(
              //   child: SizedBox(
              //     width: SizeConfig.blockSizeHorizontal,
              //   ),
              // ),
              // PrimaryText(
              //     text: 'server', //projectors.length.toString(),
              //     color: AppColors.iconDeepGray,
              //     size: 16)
            ],
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal,
          ),
          Container(
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PrimaryText(
                  text: "Bật/tắt toàn bộ servers",
                  color: AppColors.grey,
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: allRooms.power_all_servers
                          ? AppColors.navy_blue
                          : AppColors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        PowerOnAllServer();
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
                  padding: const EdgeInsets.fromLTRB(35, 0, 15, 0),
                  child: Container(
                    height: 40,
                    width: 60,
                    child: Hero(
                      tag: heroOffServer,
                      createRectTween: (begin, end) {
                        return CustomRectTween(begin: begin, end: end);
                      },
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              !allRooms.power_all_servers
                                  ? AppColors.red
                                  : AppColors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.of(context)
                                .push(HeroDialogRoute(builder: (context) {
                              return PopupOffServer(
                                onUpdateState: () {
                                  setState(() {});
                                },
                              );
                            }));
                            // PowerAllServers(false);
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
                ),
                // Transform.scale(
                //   scale: 1,
                //   child: CupertinoSwitch(
                //     value: allRooms.power_all_servers,
                //     activeColor: AppColors.navy_blue,
                //     onChanged: (value) {
                //       setState(() {
                //         PowerAllServers(true);
                //       });
                //     },
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  AllServerStatus(room: rooms[0]),
                  AllServerStatus(room: rooms[2]),
                ],
              ),
              AllServerStatus(room: rooms[3]),
              AllServerStatus(room: rooms[4]),
            ],
          )
        ],
      ),
    );
  }
}
