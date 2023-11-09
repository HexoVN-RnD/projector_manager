import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
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

const String heroAddProjector = 'popupProjector';

/// {@template add_todo_popup_card}
/// Popup card to add a new [Todo]. Should be used in conjuction with
/// [HeroDialogRoute] to achieve the popup effect.
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class PopupAddProjector extends StatefulWidget {
  /// {@macro add_todo_popup_card}

  @override
  State<PopupAddProjector> createState() => _PopupAddProjectorState();
}

class _PopupAddProjectorState extends State<PopupAddProjector> {
  final nameEditing = TextEditingController();
  final ipEditing = TextEditingController();
  final port = 3002 ;
  final position_x = TextEditingController();
  final position_y = TextEditingController();
  final UsernameAndPassword = 'admin' ;
  final type = 'PJLink' ;
  final power_status_button = false ;
  final shutter_status_button =  false;
  final power_status =  false;
  final shutter_status =  false;
  final  connected =  false;
  final isOnHover =  false;
  final lamp_hours =0;
  final status = 0 ;
  final color_state =  false;

  // late Future<int> _counter;
  late Future<Projector> projector;
  final Future<Projector> default_projector = Future.value(Projector(
      ip: '192.168.0.0',
      name: 'name',
      port: 3002,
      UsernameAndPassword: 'UsernameAndPassword',
      type: 'type',
      power_status_button: false,
      shutter_status_button: false,
      power_status: false,
      shutter_status: false,
      lamp_hours: 0,
      status: 0,
      connected: false,
      position_x: 0.5,
      position_y: 0.5,
      color_state: false,
      isOnHover: false));

  Future<Projector> getProjector(String key) async {
    final SharedPreferences new_prefs = await prefs;
    final String? jsonString = new_prefs.getString(key);
    if (jsonString != null) {
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      return Projector.fromJson(jsonMap);
    } else {
      return default_projector;
    }
  }


  // @override
  // void initState() {
  //   super.initState();
  //   // projector = default_projector;
  //   projector = getProjector('projector_1');
  // }

  @override
  void initState() {
    super.initState();
    nameEditing.text = 'Projector ';
    ipEditing.text = '192.168.';
    position_x.text = '0.0';
    position_y.text = '0.0';
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
    final width = 1100.0;
    final height = 550.0;
    return Center(
      child: Hero(
        tag: heroAddProjector,
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin, end: end);
        },
        child:
        // Scaffold(
        //   appBar: AppBar(
        //     title: const Text('SharedPreferences Demo'),
        //   ),
        //   body: Center(
        //     //     child: Text(projector.toJson().toString()),
        //     // ),
        //       child: FutureBuilder<Projector>(
        //           future: projector,
        //           builder: (BuildContext context,
        //               AsyncSnapshot<Projector> projector_snapshot) {
        //             switch (projector_snapshot.connectionState) {
        //               case ConnectionState.none:
        //               case ConnectionState.waiting:
        //                 return const CircularProgressIndicator();
        //               case ConnectionState.active:
        //               case ConnectionState.done:
        //                 if (projector_snapshot.hasError) {
        //                   return Text('Error: ${projector_snapshot.error}');
        //                 } else {
        //                   return Text(
        //                     '${projector_snapshot.data?.toJson().toString()}',
        //                   );
        //                 }
        //             }
        //           })),
        //   floatingActionButton: FloatingActionButton(
        //     onPressed: setNewProjector,
        //     tooltip: 'Increment',
        //     child: const Icon(Icons.add),
        //   ),
        // ),

        SingleChildScrollView(
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
                          setState(() async {
                            Projector projector = Projector(
                              ip: ipEditing.text,
                              name: nameEditing.text,
                              position_x: double.parse(position_x.text) ?? 0.0,
                              position_y: double.parse(position_y.text) ?? 0.0,
                              port: type == '4352'
                                  ? 4352
                                  : type == '3002'
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

                            final prefs = await SharedPreferences.getInstance();
                            prefs.setString('projectorKey',
                                json.encode(projector.toJson()));
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
                            ),
                            // Container(
                            //     margin: EdgeInsets.only(left: 20),
                            //     child: PrimaryText(
                            //       text: 'Port',
                            //       fontWeight: FontWeight.w300,
                            //       size: 14,
                            //     )),
                            // MyDropBar(
                            //   dropdownMenu: port,
                            //   defaultValue: '4352',
                            //   items: [
                            //     DropdownMenuItem<String>(
                            //         value: '4352', child: Text('4352')),
                            //     DropdownMenuItem<String>(
                            //         value: '3002', child: Text('3002'))
                            //   ],
                            // ),
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
            ]),
          ),
        ),
      ),
    );
  }
}
