import 'dart:async';

import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/PopUp/customRectTween.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/new_component/MyTextField.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

const String heroAddRoom = 'popupRoom';

/// {@template add_todo_popup_card}
/// Popup card to add a new [Todo]. Should be used in conjuction with
/// [HeroDialogRoute] to achieve the popup effect.
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class PopupAddRoom extends StatefulWidget {
  /// {@macro add_todo_popup_card}

  @override
  State<PopupAddRoom> createState() => _PopupAddRoomState();
}

class _PopupAddRoomState extends State<PopupAddRoom> {
  final idEditing = TextEditingController();
  final infoEditing = TextEditingController();
  // Timer? _timer;

  @override
  void initState() {
    super.initState();
    // _timer = Timer.periodic(Duration(milliseconds: 100), (timer) async {
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    // _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = SizeConfig.screenWidth - 200;
    final height = width * 1050 / 1920;
    return Center(
      child: Hero(
        tag: heroAddRoom,
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin, end: end);
        },
        child: SingleChildScrollView(
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(30)),
            child: Stack(alignment: Alignment.topRight, children: [
              Positioned(
                width: 190,
                height: 60,
                bottom: 20,
                right: 20,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            print('save');
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                          child: Icon(
                            Icons.task_alt,
                            size: 25,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            // print('check');
                            Navigator.of(context).pop();
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                          child: Icon(
                            Icons.highlight_off,
                            size: 25,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  width: 500,
                  child: Container(
                      padding: EdgeInsets.all(30),
                      child: Image.asset('assets/Icon/projector.png'))),
              Positioned(
                  width: 600,
                  // height: 900,
                  top: 0,
                  left: 0,
                  child: Scrollbar(
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.all(20),
                                child: PrimaryText(
                                  text: 'Add room'.toUpperCase(),
                                  fontWeight: FontWeight.w500,
                                )),
                            MyTextField(
                              textEditing: idEditing,
                              textLable: 'Room\'s Name',
                              textHint: 'Room 1',
                            ),
                            MyTextField(
                              textEditing: infoEditing,
                              textLable: 'Details',
                              textHint: 'Room information',
                            ),
                            // MyTextField(
                            //   textEditing: idEditing,
                            //   textLable: 'IP',
                            //   textHint: '192.168.0.1',
                            // ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ]),
          ),
        ),
      ),
    );
  }
}
