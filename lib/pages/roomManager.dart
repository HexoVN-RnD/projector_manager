import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/component/barChart.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/new_component/header.dart';
import 'package:responsive_dashboard/new_component/info_projector.dart';
import 'package:responsive_dashboard/pages/checkConnectionBar.dart';
import 'package:responsive_dashboard/new_component/info_server.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

class RoomManager extends StatefulWidget {
  @override
  State<RoomManager> createState() => _RoomManagerState();
}

class _RoomManagerState extends State<RoomManager> {
  void select_preset(Room room, int index) async {
    setState(() {
      room.current_preset.setValue(index);
      print(room.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    Room room = rooms[current_page.getValue() - 1];
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(
              room: room,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 4,
              child: PrimaryText(
                  text: 'Nội dung'.toUpperCase(),
                  size: 20,
                  fontWeight: FontWeight.w500),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
              decoration: BoxDecoration(
                color: AppColors.gray,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: List.generate(room.presets.length, (index) {
                  bool isSelected = room.current_preset.getValue() == index;
                  return GestureDetector(
                    onTap: () {
                      select_preset(room, index);
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
                                ? AppColors.navy_blue2
                                : AppColors.white,
                            borderRadius:
                                BorderRadius.circular(isSelected ? 20.0 : 15),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(isSelected ? 15.0 : 10),
                              child: Image.asset(
                                room.presets[index].image,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (isSelected)
                              SizedBox(
                                height: 10,
                                width: 160,
                                child: Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: LinearProgressIndicator(
                                      value:
                                          0.4, //room.presets[index].transport.getValue(),
                                      semanticsLabel:
                                          'Linear progress indicator',
                                      color: AppColors.navy_blue2,
                                      backgroundColor: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            if (isSelected)
                              SizedBox(height: SizeConfig.blockSizeVertical),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.account_balance,
                                  size: isSelected ? 26 : 15,
                                  color: AppColors.white,
                                ),
                                SizedBox(
                                    width: SizeConfig.blockSizeHorizontal *
                                        (isSelected ? 1.5 : 0.75)),
                                AnimatedDefaultTextStyle(
                                  style: isSelected
                                      ? TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w600)
                                      : TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600),
                                  duration: const Duration(milliseconds: 200),
                                  child: Text(room.presets[index].name),
                                ),
                                // PrimaryText(
                                //     text: room.presets[index].name,
                                //     size: isSelected ? 17 : 12,
                                //     color: AppColors.white,
                                //     fontWeight: FontWeight.w600),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            //List server
            SizedBox(
              height: SizeConfig.blockSizeVertical * 8,
              child: PrimaryText(
                  text: 'Quản lý server'.toUpperCase(),
                  size: 20,
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
                      room.servers.length,
                      (index) => InfoServer(server: room.servers[index]),
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
                  size: 20,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
                width: SizeConfig.screenWidth,
                child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.spaceBetween,
                    children: List.generate(
                      room.projectors.length,
                      (index) =>
                          InfoProjector(projector: room.projectors[index]),
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
              height: SizeConfig.blockSizeVertical * 4,
            ),
            if (!Responsive.isDesktop(context)) CheckConnectionBar(),
          ],
        ),
      ),
    );
  }
}
