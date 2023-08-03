import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_dashboard/Method/Control_all_projectors_void.dart';
import 'package:responsive_dashboard/Method/Osc_void.dart';
import 'package:responsive_dashboard/Method/audio_void.dart';
import 'package:responsive_dashboard/Method/projector_command.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/PopUp/MiniMap.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/new_component/manageAllProjectors.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/new_component/manageAllServers.dart';
import 'package:responsive_dashboard/pages/checkConnectionBar.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  Timer? _timer;
  Timer? _timer2;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) async {
      setState(() {});
    });
    _timer2 = Timer.periodic(Duration(milliseconds: 4000), (timer) async {
      print('check');
      for (Room room in rooms) {
        if (room.projectors.length > 0) {
          for (Projector projector in room.projectors) {
            String response = sendTCPIPCommandStatus(projector, '(PWR?)');
            print(response);
          }
        }
      }
      await Future.delayed(Duration(milliseconds: 2000));
      for (Room room in rooms) {
        if (room.projectors.length > 0) {
          for (Projector projector in room.projectors) {
            String response = sendTCPIPCommandStatus(projector, '(SHU?)');
            print(response);
          }
        }
      }
    });
  }

  void dispose() {
    _timer?.cancel();
    _timer2?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.tune,
                  size: 30,
                  color: AppColors.gray,
                ),
                SizedBox(
                  width: SizeConfig.blockSizeVertical,
                ),
                PrimaryText(
                    text: 'Trung tâm điều khiển'.toUpperCase(),
                    size: 28,
                    fontWeight: FontWeight.w600),
              ],
            ),
            PrimaryText(
              text: 'Điểu khiển toàn bộ các phòng',
              size: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.secondary,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical,
            ),

            // Container(
            //   width: 600,
            //   height: 200,
            //   child: ListView.builder(
            //     controller: scrollController,
            //     scrollDirection: Axis.horizontal,
            //     physics: const ClampingScrollPhysics(),
            //     shrinkWrap: true,
            //     itemCount: 20,
            //     keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            //     itemBuilder: (BuildContext context, int index) {
            //       return GestureDetector(
            //         onTap: (){
            //           setState(() {
            //             print(index);
            //           });
            //         },
            //         child: Container(
            //           margin: EdgeInsets.all(10),
            //           color: Colors.red,
            //           width: 50,
            //           height: 50,
            //         ),
            //       );
            //     },
            //   ),
            // ),
            Container(
              // height: 600,
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
                        Icon(
                          Icons.movie_filter,
                          size: 30,
                          color: AppColors.white,
                        ),
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
                  SingleChildScrollView(
                    // padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    // controller: controller,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(allRoom.presets.length, (index) {
                        bool isSelected =
                            allRoom.current_preset.getValue() == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              SelectAllPreset(index);
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedContainer(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                                width: isSelected ? 250.0 : 150.0,
                                height: isSelected ? 250.0 : 150.0,
                                margin: EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.navy_blue2
                                      : AppColors.white,
                                  borderRadius: BorderRadius.circular(
                                      isSelected ? 20.0 : 15),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        isSelected ? 15.0 : 10),
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
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(25, 30, 50, 0),
                    // padding: EdgeInsets.fromLTRB(20, 0, 50, 0),
                    height: 50,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          (allRoom.volume_all.getValue() != 0)
                              ? Icons.music_note
                              : Icons.music_off,
                          size: 25,
                          color: AppColors.white,
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal,
                        ),
                        PrimaryText(
                          text: "Âm thanh",
                          color: AppColors.white,
                          size: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(100, 0, 30, 0),
                            width: 300,
                            child: Transform.scale(
                              scale: 1,
                              child: Slider(
                                activeColor: AppColors.navy_blue,
                                inactiveColor: AppColors.light_navy_blue,
                                value: allRoom.volume_all.getValue(),
                                onChanged: (index) {
                                  setState(() => EditAllAudio(index));
                                },
                                onChangeEnd: (index) {
                                  setState(() => EditAllAudioAndSave(index));
                                },
                                min: 0,
                                max: 1,
                                // divisions: 5,
                              ),
                            ),
                          ),
                        ),
                        PrimaryText(
                            text: (allRoom.volume_all.getValue() * 100)
                                .toStringAsFixed(0),
                            color: AppColors.barBg,
                            size: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Wrap(
              spacing: 40,
              runSpacing: 40,
              alignment: WrapAlignment.spaceBetween,
              children: [
                ManageAllServers(),
                ManageAllProjectors(),
              ],
            ),
            // MiniMap(room: rooms[(current_page.getValue()>0)? current_page.getValue()-1:0], page: current_page.getValue()+1,),
            Wrap(
              spacing: 40,
              alignment: WrapAlignment.spaceBetween,
              children: [
                MiniMap(
                  room: rooms[0],
                  page: 1,
                ),
                MiniMap(
                  room: rooms[1],
                  page: 2,
                ),
                MiniMap(
                  room: rooms[2],
                  page: 3,
                ),
                MiniMap(
                  room: rooms[3],
                  page: 4,
                ),
              ],
            ), //power_all: PowerAllProjectors, shutter_all: ShutterAllProjectors),
            // Row(
            //   children: [
            //     Container(
            //       height: 15,
            //       width: 15,
            //       margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
            //       decoration: BoxDecoration(
            //         color: AppColors.navy_blue,
            //         borderRadius: BorderRadius.circular(5),
            //       ),
            //     ),
            //     SizedBox(
            //       width: SizeConfig.blockSizeHorizontal,
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.only(top: 8.0),
            //       child: PrimaryText(
            //         text: 'Máy chiếu đang bật'.toUpperCase(),
            //         size: 14,
            //         fontWeight: FontWeight.w500,
            //       ),
            //     ),
            //     SizedBox(
            //       width: SizeConfig.blockSizeHorizontal * 6,
            //     ),
            //     Container(
            //       height: 15,
            //       width: 15,
            //       margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
            //       decoration: BoxDecoration(
            //         color: AppColors.red,
            //         borderRadius: BorderRadius.circular(5),
            //       ),
            //     ),
            //     SizedBox(
            //       width: SizeConfig.blockSizeHorizontal,
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.only(top: 8.0),
            //       child: PrimaryText(
            //         text: 'Máy chiếu đang tắt'.toUpperCase(),
            //         size: 14,
            //         fontWeight: FontWeight.w500,
            //       ),
            //     ),
            //     SizedBox(
            //       width: SizeConfig.blockSizeHorizontal * 6,
            //     ),
            //     Container(
            //       height: 15,
            //       width: 15,
            //       margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
            //       decoration: BoxDecoration(
            //         color: AppColors.gray,
            //         borderRadius: BorderRadius.circular(5),
            //       ),
            //     ),
            //     SizedBox(
            //       width: SizeConfig.blockSizeHorizontal,
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.only(top: 8.0),
            //       child: PrimaryText(
            //         text: 'Mất kết nối'.toUpperCase(),
            //         size: 14,
            //         fontWeight: FontWeight.w500,
            //       ),
            //     ),
            //   ],
            // ),

            Row(
              children: [
                Container(
                  height: 15,
                  width: 15,
                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  decoration: BoxDecoration(
                    color: AppColors.StatusColor[2],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: PrimaryText(
                    text: 'Máy chiếu đã bật'.toUpperCase(),
                    size: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal,
                ),
                Container(
                  height: 15,
                  width: 15,
                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  decoration: BoxDecoration(
                    color: AppColors.StatusColor[3],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: PrimaryText(
                    text: 'Màn chập đã bật'.toUpperCase(),
                    size: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal,
                ),
                Container(
                  height: 15,
                  width: 15,
                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  decoration: BoxDecoration(
                    color: AppColors.StatusColor[6],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: PrimaryText(
                    text: 'Máy chiếu đang tắt'.toUpperCase(),
                    size: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal,
                ),
                Container(
                  height: 15,
                  width: 15,
                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  decoration: BoxDecoration(
                    color: AppColors.StatusColor[1],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: PrimaryText(
                    text: 'Máy chiếu đã tắt'.toUpperCase(),
                    size: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal,
                ),
                Container(
                  height: 15,
                  width: 15,
                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  decoration: BoxDecoration(
                    color: AppColors.StatusColor[0],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: PrimaryText(
                    text: 'Mất kết nối'.toUpperCase(),
                    size: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   height: SizeConfig.blockSizeVertical,
            // ),
          ],
        ),
      ),
    );
  }
}
