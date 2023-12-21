import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/style/colors.dart';

class AppBarActionItems extends StatelessWidget {
  const AppBarActionItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Container(
        //     alignment: Alignment.centerLeft,
        //     width: 150,
        //     height: 50,
        //     child: Image.asset(
        //       'assets/LogoOCB.png',
        //       // filterQuality: FilterQuality.high,
        //       fit: BoxFit.fitHeight,
        //     )),
        // SizedBox(width: 10),
        // // IconButton(
        // //     icon: SvgPicture.asset(
        // //       'assets/calendar.svg',
        // //       width: 20,
        // //     ),
        // //     onPressed: () {}),
        // // SizedBox(width: 10),
        IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              exit(0);
            }),
        // SizedBox(width: 15),
        // Row(children: [
        //   CircleAvatar(
        //     radius: 17,
        //     backgroundColor: AppColors.white,
        //     backgroundImage: AssetImage(
        //       'assets/logo.png',
        //     ),
        //     // backgroundImage: NetworkImage(
        //     //   'https://cdn.shopify.com/s/files/1/0045/5104/9304/t/27/assets/AC_ECOM_SITE_2020_REFRESH_1_INDEX_M2_THUMBS-V2-1.jpg?v=8913815134086573859',
        //     // ),
        //   ),
        //   // Icon(Icons.arrow_drop_down_outlined, color: AppColors.black)
        // ]),
      ],
    );
  }
}
