import 'package:flutter/material.dart';
import 'package:responsive_dashboard/component/paymentListTile.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

class PaymentDetailList extends StatelessWidget {
  const PaymentDetailList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: SizeConfig.blockSizeVertical * 5,
      ),
      // Container(
      //   decoration:
      //       BoxDecoration(borderRadius: BorderRadius.circular(30), boxShadow: [
      //     BoxShadow(
      //       color: Colors.grey[400],
      //       blurRadius: 15.0,
      //       offset: const Offset(
      //         10.0,
      //         15.0,
      //       ),
      //     )
      //   ]),
      //   child: Image.asset('assets/card.png'),
      // ),
      // SizedBox(
      //   height: SizeConfig.blockSizeVertical * 5,
      // ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryText(
              text: 'Room 4', size: 18, fontWeight: FontWeight.w800),
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
          projectors.length,
          (index) => PaymentListTile(projector: projectors[index],),
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
          projectors.length,
          (index) => PaymentListTile(projector: projectors[index],),
        ),
      ),
    ]);
  }
}
