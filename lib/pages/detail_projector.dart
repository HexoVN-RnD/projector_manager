import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Room.dart';
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
import 'package:valuable/valuable.dart';

final StatefulValuable<int> currentRoom = StatefulValuable<int>(0);

class DetailProjector extends StatefulWidget {
  @override
  State<DetailProjector> createState() => _DetailProjector();
}

class _DetailProjector extends State<DetailProjector> {
  List<Projector> list_projector = rooms[currentRoom.getValue()].projectors;

  bool shouldRefreshList = false;

  void refreshList() {
    // Simulate a network delay
    setState(() {
      list_projector = rooms[currentRoom.getValue()].projectors;
      shouldRefreshList = !shouldRefreshList;
      print(shouldRefreshList);
    });
  }
  Future<void> double_refreshList() async {
    // Simulate a network delay
    await Future.delayed(Duration(milliseconds: 100));
    setState(() {
      list_projector = rooms[currentRoom.getValue()].projectors;
      shouldRefreshList = !shouldRefreshList;
      print(shouldRefreshList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Row(
              children: List.generate(rooms.length, (index) {
                bool isSelected = currentRoom.getValue() == index;
                return GestureDetector(
                  onTap: () {
                    refreshList();
                    double_refreshList();
                    setState(() {
                      currentRoom.setValue(index);
                      print(currentRoom.getValue());
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    width: isSelected ? 180.0 : 120.0,
                    height: isSelected ? 60.0 : 40.0,
                    margin: EdgeInsets.only(right: 20.0),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.green : AppColors.black,
                      borderRadius:
                          BorderRadius.circular(isSelected ? 20.0 : 15),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_balance,
                            size: isSelected ? 26 : 15,
                            color: AppColors.white,
                          ),
                          SizedBox(width: SizeConfig.blockSizeVertical),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PrimaryText(
                                  text: rooms[index].name,
                                  size: isSelected ? 17 : 12,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600),
                              if (isSelected)
                                PrimaryText(
                                    text: rooms[index].general,
                                    size: 10,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w400),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 4,
            ),
            // List Projector
            SizedBox(
              width: SizeConfig.screenWidth,
              child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  alignment: WrapAlignment.spaceBetween,
                  children: List.generate(
                    list_projector.length,
                    (index) =>  shouldRefreshList? InfoProjector(projector: list_projector[index]): SizedBox(),
                  )
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 4,
            ),
            if (!Responsive.isDesktop(context)) PaymentDetailList(),
          ],
        ),
      ),
    );
  }
}
