import 'dart:async';

import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/RoomData.dart';
import 'package:responsive_dashboard/PopUp/customRectTween.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/Shared_Prefs_Method.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/new_component/MyTextField.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

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
  final nameEditing = TextEditingController();
  final infoEditing = TextEditingController();
  // late Room room;
  late RoomData roomdata;
  // late Future<List<Projector>> listProjector;

  late Future<Map<String, dynamic>> allRoom;
  // Timer? _timer;

  @override
  void initState() {
    super.initState();
    nameEditing.text = 'Room ';
    infoEditing.text = 'Show ';
    // roomdata = getRoomData('room_1');
    // allRoom = getAllDataByKey('room');
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
    final width = 600.0;
    final height = 370.0;
    return Center(
      child: SingleChildScrollView(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(30)),
            child: Stack(alignment: Alignment.topRight, children: [
              // Positioned(
              //   child: FutureBuilder<Room>(
              //       future: room,
              //       builder: (BuildContext context,
              //           AsyncSnapshot<Room> room_snapshot) {
              //         switch (room_snapshot.connectionState) {
              //           case ConnectionState.none:
              //             return SizedBox();
              //           case ConnectionState.waiting:
              //             return const CircularProgressIndicator();
              //           case ConnectionState.active:
              //           case ConnectionState.done:
              //             if (room_snapshot.hasError) {
              //               print(room_snapshot.error);
              //               return Text('${room_snapshot.error}');
              //             } else {
              //               return Text('${room_snapshot.data?.toString()}');
              //               //   Text(
              //               //   '${room_snapshot.data?.toJson().toString()}',
              //               // );
              //             }
              //         }
              //       }),
              // ),
              // Positioned(
              //   child: FutureBuilder<RoomData>(
              //       future: roomdata,
              //       builder: (BuildContext context,
              //           AsyncSnapshot<RoomData> room_snapshot) {
              //         switch (room_snapshot.connectionState) {
              //           case ConnectionState.none:
              //             return SizedBox();
              //           case ConnectionState.waiting:
              //             return const CircularProgressIndicator();
              //           case ConnectionState.active:
              //           case ConnectionState.done:
              //             if (room_snapshot.hasError) {
              //               return Text('${room_snapshot.error}');
              //             } else {
              //               return Text('${room_snapshot.data?.toJson().toString()}');
              //               //   Text(
              //               //   '${room_snapshot.data?.toJson().toString()}',
              //               // );
              //             }
              //         }
              //       }),
              // ),

              Positioned(
                width: 190,
                height: 60,
                bottom: 30,
                right: 40,
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
                          final RoomData new_room = RoomData(
                              nameUI: nameEditing.text,
                              nameDatabase: nameEditing.text,
                              power_room_projectors: false,
                              shutter_room_projectors: false,
                              isSelectedPlay: false,
                              isSelectedStop: false,
                              resolume: false,
                              map: '',
                              general: infoEditing.text,
                              current_preset: 10,
                              roomVolumeId: '');
                          setState(() {
                            // roomdata = Future.value(new_room);
                            addNewRoomData(new_room);
                            Navigator.of(context).pop;
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
              // Positioned(
              //     width: 500,
              //     child: Container(
              //         padding: EdgeInsets.all(30),
              //         child: Image.asset('assets/Icon/room.png'))),
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
                              textEditing: nameEditing,
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