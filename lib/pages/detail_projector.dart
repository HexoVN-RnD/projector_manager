import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/component/barChart.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/old_component/header.dart';
import 'package:responsive_dashboard/component/historyTable.dart';
import 'package:responsive_dashboard/old_component/info_projector.dart';
import 'package:responsive_dashboard/component/ConnectionDetailList.dart';
import 'package:responsive_dashboard/old_component/info_server.dart';
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
  List<Server> list_server = rooms[currentRoom.getValue()].servers;

  bool shouldRefreshList = true;

  void refreshList() async {

    await current_page.setValue(0);
    // Simulate a network delay
    setState(() {
      list_projector = rooms[currentRoom.getValue()].projectors;
      list_server = rooms[currentRoom.getValue()].servers;
      shouldRefreshList = !shouldRefreshList;
      print(shouldRefreshList);
    });
  }
  Future<void> double_refreshList() async {
    // Simulate a network delay
    await Future.delayed(Duration(milliseconds: 300));
    setState(() {
      list_projector = rooms[currentRoom.getValue()].projectors;
      list_server = rooms[currentRoom.getValue()].servers;
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
                      color: isSelected ? AppColors.navy_blue : AppColors.black,
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
            SizedBox(
              height: SizeConfig.blockSizeVertical * 8,
                child: PrimaryText(
                    text: 'Quản lý server'.toUpperCase(),
                    size: 24,
                    fontWeight: FontWeight.w500),
            ),

            // List Projector
            SizedBox(
              width: SizeConfig.screenWidth,
              child: shouldRefreshList? Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  alignment: WrapAlignment.spaceBetween,
                  children: List.generate(
                    list_server.length,
                        (index) => InfoServer(server: list_server[index]),
                  )
              ): SpinKitThreeBounce(color: AppColors.navy_blue, size: 20,),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 4,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 8,
              child: PrimaryText(
                  text: 'Quản lý máy chiếu'.toUpperCase(),
                  size: 24,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: SizeConfig.screenWidth,
              child: shouldRefreshList? Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  alignment: WrapAlignment.spaceBetween,
                  children: List.generate(
                    list_projector.length,
                    (index) => InfoProjector(projector: list_projector[index]),
                  )
              ): SpinKitThreeBounce(color: AppColors.navy_blue, size: 20,),
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
