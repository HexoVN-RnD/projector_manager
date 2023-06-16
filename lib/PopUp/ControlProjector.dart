import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Method/projector_void.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/PopUp/customRectTween.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/new_component/manageAllProjectors.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

const String heroControlProjector = 'control-projector';

/// {@template add_todo_popup_card}
/// Popup card to add a new [Todo]. Should be used in conjuction with
/// [HeroDialogRoute] to achieve the popup effect.
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class ControlProjector extends StatefulWidget {
  /// {@macro add_todo_popup_card}
  Projector projector;
  ControlProjector({
    required this.projector,
  });

  @override
  State<ControlProjector> createState() => _ControlProjectorState();
}

class _ControlProjectorState extends State<ControlProjector> {
  @override
  Widget build(BuildContext context) {
    Projector projector = widget.projector;
    final width = Responsive.isDesktop(context)
        ? SizeConfig.screenWidth - 400
        : SizeConfig.screenWidth - 60;
    final height = width * 1050 / 1920;
    return Center(
      child: Hero(
        tag: heroControlProjector,
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin, end: end);
        },
        child: SingleChildScrollView(
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                color: AppColors.gray,
                borderRadius: BorderRadius.circular(30)),
            child: Stack(alignment: Alignment.topRight, children: [
              Padding(
                // padding: EdgeInsets.only(left: width-10,bottom: height-10),
                padding:
                EdgeInsets.only(left: width - 100, bottom: height - 100),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white_trans,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      // print('check');
                      Navigator.of(context).pop();
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: Icon(
                      Icons.zoom_out,
                      size: 25,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              Column(
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
                  ManageAllProjectors(),

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
                                  text: 'Test parttern',
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
                                  allRoom.current_test_pattern.getValue() == index;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    TestPatternSelect(projector, index);
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
                                            height: isSelected ? 250.0 : 150.0,
                                            fit: BoxFit.fitHeight,
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
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
