import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/component/barChart.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/new_component/header.dart';
import 'package:responsive_dashboard/component/historyTable.dart';
import 'package:responsive_dashboard/new_component/info_projector.dart';
import 'package:responsive_dashboard/new_component/checkConnectionBar.dart';
import 'package:responsive_dashboard/new_component/info_server.dart';
import 'package:responsive_dashboard/new_component/projector_manager.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';
import 'package:valuable/valuable.dart';


class RoomManager extends StatefulWidget {

  @override
  State<RoomManager> createState() => _RoomManagerState();
}

class _RoomManagerState extends State<RoomManager> {
  // int no_room;

  // _RoomManagerState(int no_room);
  // List<Projector> list_projector = rooms[current_page.getValue()].projectors;
  // List<Server> list_server = rooms[current_page.getValue()].servers;

  // bool shouldRefreshList = true;

  // void refreshList() async {
  //   await current_page.setValue(0);
  //   // Simulate a network delay
  //   setState(() {
  //     list_projector = rooms[current_page.getValue()].projectors;
  //     list_server = rooms[current_page.getValue()].servers;
  //     // shouldRefreshList = !shouldRefreshList;
  //     // print(shouldRefreshList);
  //   });
  // }
  // Future<void> double_refreshList() async {
  //   // Simulate a network delay
  //   await Future.delayed(Duration(milliseconds: 300));
  //   setState(() {
  //     list_projector = rooms[current_page.getValue()].projectors;
  //     list_server = rooms[current_page.getValue()].servers;
  //     shouldRefreshList = !shouldRefreshList;
  //     print(shouldRefreshList);
  //   });
  // }

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
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: List.generate(rooms[current_page.getValue()-1].presets.length, (index) {
                  bool isSelected = rooms[current_page.getValue()-1].current_preset.getValue() == index;
                  return GestureDetector(
                    onTap: () {
                      // refreshList();
                      // double_refreshList();
                      setState(() {
                        rooms[current_page.getValue()-1].current_preset.setValue(index);
                        print(rooms[current_page.getValue()-1].current_preset.getValue());
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          width: isSelected ? 180.0 : 120.0,
                          height: isSelected ? 180.0 : 120.0,
                          margin: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.navy_blue
                                : AppColors.black,
                            borderRadius:
                                BorderRadius.circular(isSelected ? 20.0 : 15),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Image.asset(rooms[current_page.getValue()].presets[index].image),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.account_balance,
                                  size: isSelected ? 26 : 15,
                                  color: AppColors.primary,
                                ),
                                SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 2),
                                PrimaryText(
                                    text: rooms[current_page.getValue()].presets[index].name,
                                    size: isSelected ? 17 : 12,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600),
                              ],
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical),
                            if (isSelected)
                              PrimaryText(
                                  text: rooms[current_page.getValue()].presets[index].transport.getValue().toString(),
                                  size: 12,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 4,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 8,
              child: PrimaryText(
                  text: rooms[current_page.getValue()-1].name,//'Quản lý server'.toUpperCase(),
                  size: 24,
                  fontWeight: FontWeight.w500),
            ),

            // List Projector
            SizedBox(
                width: SizeConfig.screenWidth,
                child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.spaceBetween,
                    children: List.generate(
                      rooms[current_page.getValue()-1].servers.length,
                      (index) =>
                          InfoServer(server: rooms[current_page.getValue()-1].servers[index]),
                    ))
                // : SpinKitThreeBounce(
                //     color: AppColors.navy_blue,
                //     size: 20,
                //   ),
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
                child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.spaceBetween,
                    children: List.generate(
                      rooms[current_page.getValue()-1].projectors.length,
                      (index) => InfoProjector(
                          projector: rooms[current_page.getValue()-1].projectors[index]),
                    ))
                // : SpinKitThreeBounce(
                //     color: AppColors.navy_blue,
                //     size: 20,
                //   ),
                ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 4,
            ),
            if (!Responsive.isDesktop(context)) CheckConnectionBar(),
          ],
        ),
      ),
    );
  }
}
