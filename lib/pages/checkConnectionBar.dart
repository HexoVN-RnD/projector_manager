import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Method/ping_check_connection.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/new_component/serverConnection.dart';
import 'package:responsive_dashboard/new_component/projectorConnection.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/pages/roomManager.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

class CheckConnectionBar extends StatefulWidget {
  @override
  State<CheckConnectionBar> createState() => _CheckConnectionBarState();
}

class _CheckConnectionBarState extends State<CheckConnectionBar> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: SizeConfig.blockSizeVertical * 4,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: PrimaryText(
                    text: rooms[(current_page.getValue() > 0)
                            ? current_page.getValue() - 1
                            : 1]
                        .name,
                    size: 18,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                width: 110,
                child: ElevatedButton(

                  style:ElevatedButton.styleFrom(
                    backgroundColor: AppColors.navy_blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      CheckRoomConnection();
                    });
                  },
                  child: PrimaryText(text: 'Kiểm tra',
                  size: 14,
                  // color: AppColors.white,
                  fontWeight: FontWeight.w500,),
                ),
              )

            ],
          ),

          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
            height: Responsive.isDesktop(context)? MediaQuery.of(context).size.width/6: MediaQuery.of(context).size.width/1.66,
            decoration: BoxDecoration(
              color: AppColors.gray,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          PrimaryText(
            text: 'Kiểm tra tín hiệu server',
            size: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.iconDeepGray,
          ),
        ],
      ),
      SizedBox(
        height: SizeConfig.blockSizeVertical * 2,
      ),
      Column(
        children: List.generate(
          rooms[(current_page.getValue() > 0) ? current_page.getValue() - 1 : 1]
              .servers
              .length,
          (index) => ServerConnection(
            server: rooms[(current_page.getValue() > 0)
                    ? current_page.getValue() - 1
                    : 1]
                .servers[index],
          ),
        ),
      ),
      SizedBox(
        height: SizeConfig.blockSizeVertical * 2,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryText(
            text: 'Kiểm tra tín hiệu máy chiếu',
            size: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.iconDeepGray,
          ),
        ],
      ),
      SizedBox(
        height: SizeConfig.blockSizeVertical * 2,
      ),
      Column(
        children: List.generate(
          rooms[(current_page.getValue() > 0) ? current_page.getValue() - 1 : 1]
              .projectors
              .length,
          (index) => ProjectorConnection(
            projector: rooms[(current_page.getValue() > 0)
                    ? current_page.getValue() - 1
                    : 1]
                .projectors[index],
          ),
        ),
      ),
    ]);
  }
}
