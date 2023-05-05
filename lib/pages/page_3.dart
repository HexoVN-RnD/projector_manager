import 'package:flutter/material.dart';
import 'package:responsive_dashboard/component/barChart.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/old_component/header.dart';
import 'package:responsive_dashboard/component/historyTable.dart';
import 'package:responsive_dashboard/old_component/info_projector.dart';
import 'package:responsive_dashboard/component/paymentDetailList.dart';
import 'package:responsive_dashboard/old_component/projector_manager.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

class Page3 extends StatefulWidget {
  @override
  State<Page3> createState() => _Page3();
}

class _Page3 extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryText(
                    text: 'History',
                    size: 30,
                    fontWeight: FontWeight.w800),
                PrimaryText(
                  text: 'Transaction of lat 6 month',
                  size: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondary,
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            HistoryTable(),
            if (!Responsive.isDesktop(context)) PaymentDetailList()
          ],
        ),
      ),
    );
  }
}