import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_dashboard/Method/Control_all_room_void.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';


class ManageAllServers extends StatefulWidget {

  @override
  _ManageAllServersState createState() => _ManageAllServersState();
}

class _ManageAllServersState extends State<ManageAllServers> {

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: Responsive.isDesktop(context) ? 600 : SizeConfig.screenWidth - 40,
                                  maxWidth: Responsive.isDesktop(context) ? SizeConfig.screenWidth-40 : SizeConfig.screenWidth- 40),
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
                SvgPicture.asset('assets/credit-card.svg', width: 35, color: AppColors.gray),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal,
                ),
                PrimaryText(
                  text: 'Quản lý servers',
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
                text: 'server',//projectors.length.toString(),
                color: AppColors.iconDeepGray,
                size: 16
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PrimaryText(
                  text: "Bật/tắt toàn bộ servers",
                  color: AppColors.gray,
                  size: 18,
                  fontWeight: FontWeight.w500,
                ),
                Expanded(
                  child: SizedBox(
                    width: SizeConfig.blockSizeHorizontal,
                  ),
                ),
                Transform.scale(
                  scale: 1,
                  child: CupertinoSwitch(
                    value: allRoom.power_all_servers.getValue(),
                    activeColor: AppColors.navy_blue,
                    onChanged: (value) {
                      setState(() {
                        PowerAllServers();
                      });
                    },
                  ),
                ),
              ],
            ),
            PrimaryText(
                text: 'Phòng 2 đã bật 2/2',
                color: AppColors.iconDeepGray,
                size: 16),
            PrimaryText(
                text: 'Phòng 4 đã bật 2/2',
                color: AppColors.iconDeepGray,
                size: 16),
            PrimaryText(
                text: 'Phòng 5 đã bật 2/2',
                color: AppColors.iconDeepGray,
                size: 16),
            PrimaryText(
                text: 'Phòng 6 đã bật 2/2',
                color: AppColors.iconDeepGray,
                size: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PrimaryText(
                  text: "Điều chỉnh âm thanh",
                  color: AppColors.gray,
                  size: 18,
                  fontWeight: FontWeight.w500,
                ),
                Expanded(
                  child: SizedBox(
                    width: SizeConfig.blockSizeHorizontal,
                  ),
                ),
                PrimaryText(
                    text:allRoom.volume_all.getValue().toStringAsFixed(2),
                    color: AppColors.iconDeepGray,
                    size: 16),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal,
                ),
                Transform.scale(
                  scale: 1,
                  child: Slider(
                    activeColor: AppColors.navy_blue,
                    value: allRoom.volume_all.getValue(),
                    onChanged: (index) {
                      setState(() => ChangeAllVolume(index));
                    },
                    min: 0,
                    max: 1,
                    // divisions: 5,
                  ),
                ),
              ],
            ),
          ],
        ),);
  }
}