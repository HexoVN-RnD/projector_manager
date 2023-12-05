import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/data/Shared_Prefs_Method.dart';
import 'package:responsive_dashboard/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/PopUp/customRectTween.dart';
import 'package:responsive_dashboard/new_component/MyDropBar.dart';
import 'package:responsive_dashboard/new_component/MyTextField.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String heroAddProjectorNew = 'popupProjectorNew';

/// {@template add_todo_popup_card}
/// Popup card to add a new [Todo]. Should be used in conjuction with
/// [HeroDialogRoute] to achieve the popup effect.
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class PopupAddProjector extends StatefulWidget {
  String roomKey;
  PopupAddProjector({
    required this.roomKey,
});
  /// {@macro add_todo_popup_card}

  @override
  State<PopupAddProjector> createState() => _PopupAddProjectorState();
}

class _PopupAddProjectorState extends State<PopupAddProjector> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameEditing = TextEditingController();
  final ipEditing = TextEditingController();
  final position_x = TextEditingController();
  final position_y = TextEditingController();
  String type = 'PJLink';
  // late Future<Map<String, dynamic>> allDatas;
  // late Future<Projector> projector;

  @override
  void initState() {
    super.initState();
    nameEditing.text = 'Projector ';
    ipEditing.text = '192.168.';
    position_x.text = '0.0';
    position_y.text = '0.0';
    // projector = getProjector('projector_1');
    // allDatas = getAllDataByKey('projector');
  }

  @override
  Widget build(BuildContext context) {
    final width = 1100.0;
    final height = 550.0;
    return Center(
      child: Hero(
        tag: heroAddProjectorNew,
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin, end: end);
        },
        child: Material(
          color: Colors.transparent,
          child: Form(
            key: _formKey,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(30)),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
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
                            onPressed: () async {
                              final Projector new_projector = Projector(
                                roomKey: widget.roomKey,
                                ip: ipEditing.text,
                                name: nameEditing.text,
                                position_x: double.parse(position_x.text),
                                position_y: double.parse(position_y.text),
                                port: type == 'PJLink'
                                    ? 4352
                                    : type == 'TCPIP'
                                        ? 3002
                                        : 0000,
                                UsernameAndPassword: 'admin',
                                type: type,
                                power_status_button: false,
                                shutter_status_button: false,
                                power_status: false,
                                shutter_status: false,
                                connected: false,
                                isOnHover: false,
                                lamp_hours: 0,
                                status: 0,
                                color_state: false,
                              );
                              setState(() {
                                if (_formKey.currentState!.validate()) {
                                  // projector = Future.value(new_projector);
                                  addNewProjector(new_projector);
                                  Navigator.of(context).pop;
                                }
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
                      right: 0,
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
                                      text: 'Add projector'.toUpperCase(),
                                      fontWeight: FontWeight.w500,
                                    )),
                                MyTextField(
                                  textEditing: nameEditing,
                                  textLable: 'Projector\'s Name',
                                  textHint: 'Christie',
                                ),
                                MyTextField(
                                  textEditing: ipEditing,
                                  textLable: 'IP',
                                  textHint: '192.168.0.1',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This value cannot empty';
                                    } else if (value == '192.168.' ||
                                        value.isEmpty) {
                                      return 'Please fill full IP';
                                    } else if (!isIP(value)) {
                                      return 'Wrong IP format';
                                    }
                                  },
                                ),
                                Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: PrimaryText(
                                      text: 'Command Type',
                                      fontWeight: FontWeight.w300,
                                      size: 14,
                                    )),
                                MyDropBar(
                                  dropdownMenu: type,
                                  defaultValue: 'PJLink',
                                  items: [
                                    DropdownMenuItem<String>(
                                        value: 'PJLink', child: Text('PJLink')),
                                    DropdownMenuItem<String>(
                                        value: 'TCPIP', child: Text('TCPIP')),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      type = value ?? 'PJLink';
                                      print(type);
                                    });
                                  },
                                ),
                                Row(
                                  children: [
                                    MyTextField(
                                      width: 230,
                                      textEditing: position_x,
                                      textLable: 'Position-x in map',
                                      textHint: '0.0',
                                      onChanged: (value) {},
                                    ),
                                    // Expanded(child: SizedBox()),
                                    Expanded(
                                      child: MyTextField(
                                        textEditing: position_y,
                                        textLable: 'Position-y in map',
                                        textHint: '0.0',
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ],
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
                  // FutureBuilder<Map<String, dynamic>>(
                  //     future: allDatas,
                  //     builder: (BuildContext context,
                  //         AsyncSnapshot<Map<String, dynamic>>
                  //             projector_snapshot) {
                  //       switch (projector_snapshot.connectionState) {
                  //         case ConnectionState.none:
                  //           return SizedBox();
                  //         case ConnectionState.waiting:
                  //           return const CircularProgressIndicator();
                  //         case ConnectionState.active:
                  //         case ConnectionState.done:
                  //           print(projector_snapshot.data.toString());
                  //           if (projector_snapshot.hasError) {
                  //             return Text('${projector_snapshot.error}');
                  //           } else {
                  //             return Text(
                  //                 '${projector_snapshot.data?.toString()}');
                  //             //   Text(
                  //             //   '${projector_snapshot.data?.toJson().toString()}',
                  //             // );
                  //           }
                  //       }
                  //     }),
                  // Positioned(
                  //   bottom: 0,
                  //   child: GestureDetector(
                  //     onTap: () async {
                  //       final Projector new_projector = Projector(
                  //         ip: ipEditing.text,
                  //         name: nameEditing.text,
                  //         position_x: double.parse(position_x.text),
                  //         position_y: double.parse(position_y.text),
                  //         port: type == '4352'
                  //             ? 4352
                  //             : type == '3002'
                  //                 ? 3002
                  //                 : 0000,
                  //         UsernameAndPassword: 'admin',
                  //         type: type,
                  //         power_status_button: false,
                  //         shutter_status_button: false,
                  //         power_status: false,
                  //         shutter_status: false,
                  //         connected: false,
                  //         isOnHover: false,
                  //         lamp_hours: 0,
                  //         status: 0,
                  //         color_state: false,
                  //       );
                  //       final SharedPreferences new_prefs = await prefs;
                  //       // final Projector new_projector = Projector(
                  //       //     ip: '192.168.3.3',
                  //       //     name: 'Christie',
                  //       //     port: 3002,
                  //       //     UsernameAndPassword: 'admin',
                  //       //     type: 'PJLink',
                  //       //     power_status_button: false,
                  //       //     shutter_status_button: false,
                  //       //     power_status: false,
                  //       //     shutter_status: false,
                  //       //     lamp_hours: 0,
                  //       //     status: 0,
                  //       //     connected: false,
                  //       //     position_x: 0.0,
                  //       //     position_y: 0.0,
                  //       //     color_state: false,
                  //       //     isOnHover: false);
                  //       setState(() {
                  //         projector = Future.value(new_projector);
                  //         addNewProjector(new_projector, 'projector_1');
                  //       });
                  //     },
                  //     child: Container(
                  //       width: 100,
                  //       height: 50,
                  //       child: Icon(Icons.add),
                  //     ),
                  //   ),
                  // ),
                  // Positioned(
                  //   left: 300,
                  //   bottom: 0,
                  //   child: GestureDetector(
                  //     onTap: () async {
                  //       deleteAllData();
                  //       setState(() {
                  //         projector = Future.error(('Data cannot found '));
                  //       });
                  //       // setState(() {
                  //       //   //clear this prefs
                  //       //   // new_prefs.clear();
                  //       // });
                  //     },
                  //     child: Container(
                  //       width: 100,
                  //       height: 50,
                  //       child: Icon(Icons.delete),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              // floatingActionButton: FloatingActionButton(
              //   onPressed: setNewProjector,
              //   tooltip: 'Increment',
              //   child: const Icon(Icons.add),
              // ),
            ),
          ),
        ),
      ),
    );
  }
}
