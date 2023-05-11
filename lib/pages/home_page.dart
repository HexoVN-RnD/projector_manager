import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_dashboard/Method/Control_all_room_void.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/new_component/manageAllProjectors.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/new_component/manageAllServers.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // AllRoom allRoom = allRoom;
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
              height: SizeConfig.blockSizeVertical,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
              decoration: BoxDecoration(
                color: AppColors.gray,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20),
                    height: SizeConfig.blockSizeVertical * 4,
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/credit-card.svg', width: 35, color: AppColors.white),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal,
                        ),
                        PrimaryText(
                          color: AppColors.white,
                            text: 'Nội dung',
                            size: 20,
                            fontWeight: FontWeight.w500),
                      ],
                    ),
                  ),
                  Row(
                    children: List.generate(allRoom.presets.length, (index) {
                      bool isSelected = allRoom.current_preset.getValue() == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            select_preset(index);
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
                                    allRoom.presets[index].image,
                                  ),
                                ),
                              ),
                            ),
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
                                  child: Text(allRoom.presets[index].name),
                                ),
                                // PrimaryText(
                                //     text: allRoom.presets[index].name,
                                //     size: isSelected ? 17 : 12,
                                //     color: AppColors.white,
                                //     fontWeight: FontWeight.w600),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            ManageAllServers(),//power_all: PowerAllProjectors, shutter_all: ShutterAllProjectors),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 4,
            ),
            ManageAllProjectors(),//power_all: PowerAllProjectors, shutter_all: ShutterAllProjectors),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 4,
            ),
          ],
        ),
      ),
    );
  }
}
