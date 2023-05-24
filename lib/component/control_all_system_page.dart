// import 'package:flutter/material.dart';
// import 'package:responsive_dashboard/component/barChart.dart';
// import 'package:responsive_dashboard/dashboard.dart';
// import 'package:responsive_dashboard/data/data.dart';
// import 'package:responsive_dashboard/new_component/header.dart';
// import 'package:responsive_dashboard/component/historyTable.dart';
// import 'package:responsive_dashboard/new_component/info_projector.dart';
// import 'package:responsive_dashboard/pages/checkConnectionBar.dart';
// import 'package:responsive_dashboard/new_component/manageAllProjectors.dart';
// import 'package:responsive_dashboard/config/responsive.dart';
// import 'package:responsive_dashboard/config/size_config.dart';
// import 'package:responsive_dashboard/style/colors.dart';
// import 'package:responsive_dashboard/style/style.dart';
//
// class HomePage extends StatefulWidget {
//   @override
//   State<HomePage> createState() => _HomePage();
// }
//
// class _HomePage extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Header(room: rooms[current_page.getValue()-1],),
//             SizedBox(
//               height: SizeConfig.blockSizeVertical * 2,
//             ),
//             // ProjectorsManager(),
//             SizedBox(
//               height: SizeConfig.blockSizeVertical * 4,
//             ),
//             PrimaryText(
//                 text: 'Details projector',
//                 size: 30,
//                 fontWeight: FontWeight.w800),
//             PrimaryText(
//               text: 'Manager each projector',
//               size: 16,
//               fontWeight: FontWeight.w400,
//               color: AppColors.secondary,
//             ),
//             SizedBox(
//               height: SizeConfig.blockSizeVertical * 4,
//             ),
//             SizedBox(
//               width: SizeConfig.screenWidth,
//               child: Wrap(
//                 spacing: 20,
//                 runSpacing: 20,
//                 alignment: WrapAlignment.spaceBetween,
//                 children: [
//                   // InfoProjector(projector: projectors[0]),
//                   // InfoProjector(projector: projectors[1]),
//                   // InfoProjector(projector: projectors[2]),
//                   // InfoProjector(projector: projectors[3]),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: SizeConfig.blockSizeVertical * 4,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     PrimaryText(
//                       text: 'Balance',
//                       size: 16,
//                       fontWeight: FontWeight.w400,
//                       color: AppColors.secondary,
//                     ),
//                     PrimaryText(
//                         text: '\$1500',
//                         size: 30,
//                         fontWeight: FontWeight.w800),
//                   ],
//                 ),
//                 PrimaryText(
//                   text: 'Past 30 DAYS',
//                   size: 16,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.secondary,
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: SizeConfig.blockSizeVertical * 3,
//             ),
//             Container(
//               height: 180,
//               child: BarChartCopmponent(),
//             ),
//             SizedBox(
//               height: SizeConfig.blockSizeVertical * 5,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 PrimaryText(
//                     text: 'History',
//                     size: 30,
//                     fontWeight: FontWeight.w800),
//                 PrimaryText(
//                   text: 'Transaction of lat 6 month',
//                   size: 16,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.secondary,
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: SizeConfig.blockSizeVertical * 3,
//             ),
//             // HistoryTable(),
//             if (!Responsive.isDesktop(context) && current_page.getValue() != 0) CheckConnectionBar()
//           ],
//         ),
//       ),
//     );
//   }
// }