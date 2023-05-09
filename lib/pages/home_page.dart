import 'package:flutter/material.dart';
import 'package:responsive_dashboard/new_component/projector_manager.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryText(
                text: 'Projectors Manager',
                size: 30,
                fontWeight: FontWeight.w800),
            PrimaryText(
              text: 'Control all projectors',
              size: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.secondary,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            ProjectorsManager(),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 4,
            ),
          ],
        ),
      ),
    );
  }
}