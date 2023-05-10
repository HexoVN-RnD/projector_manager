import 'package:flutter/material.dart';
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
        height: SizeConfig.blockSizeVertical * 3,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryText(text: rooms[(current_page.getValue()>0)? current_page.getValue()-1: 1].name, size: 18, fontWeight: FontWeight.w800),
          PrimaryText(
            text: 'Kiểm tra tín hiệu server',
            size: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.secondary,
          ),
        ],
      ),
      SizedBox(
        height: SizeConfig.blockSizeVertical * 2,
      ),
      Column(
        children: List.generate(
          rooms[(current_page.getValue()>0)? current_page.getValue()-1: 1].servers.length,
          (index) => ServerConnection(
            server: rooms[(current_page.getValue()>0)? current_page.getValue()-1: 1].servers[index],
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
            size: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.secondary,
          ),
        ],
      ),
      SizedBox(
        height: SizeConfig.blockSizeVertical * 2,
      ),
      Column(
        children: List.generate(
          rooms[(current_page.getValue()>0)? current_page.getValue()-1: 1].projectors.length,
          (index) => ProjectorConnection(
            projector: rooms[(current_page.getValue()>0)? current_page.getValue()-1: 1].projectors[index],
          ),
        ),
      ),
    ]);
  }
}
