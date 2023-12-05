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

/// {@template add_todo_popup_card}
/// Popup card to add a new [Todo]. Should be used in conjuction with
/// [HeroDialogRoute] to achieve the popup effect.
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class PopupUpdateProjector extends StatefulWidget {
  Projector projector;
  String projectorKey;
  PopupUpdateProjector({
    required this.projector,
    required this.projectorKey,
  });
  /// {@macro add_todo_popup_card}

  @override
  State<PopupUpdateProjector> createState() => _PopupUpdateProjectorState();
}

class _PopupUpdateProjectorState extends State<PopupUpdateProjector> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameEditing = TextEditingController();
  final ipEditing = TextEditingController();
  final position_x = TextEditingController();
  final position_y = TextEditingController();
  String type = 'PJLink';
  // late Future<Map<String, dynamic>> allDatas;
  // late Projector widget.projector;
  late SharedPreferences new_prefs;

  // Future<void> getProjectorData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   widget.projector = getProjector(prefs, widget.projectorKey);
  // }
  @override
  void initState() {
    super.initState();
    // getProjectorData();
    nameEditing.text = widget.projector.name;
    ipEditing.text = widget.projector.ip;
    position_x.text = widget.projector.position_x.toString();
    position_y.text = widget.projector.position_y.toString();
    type = widget.projector.type;
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // getProjectorData();
    final width = 1100.0;
    final height = 550.0;
    return Center(
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
                              roomKey: widget.projector.roomKey,
                              ip: ipEditing.text,
                              name: nameEditing.text,
                              position_x: widget.projector.position_x,
                              position_y: widget.projector.position_y,
                              port: type == 'PJLink'
                                  ? 4352
                                  : type == 'TCPIP'
                                  ? 3002
                                  : 0000,
                              UsernameAndPassword: widget.projector.UsernameAndPassword,
                              type: type,
                              power_status_button: widget.projector.power_status_button,
                              shutter_status_button: widget.projector.shutter_status_button,
                              power_status: widget.projector.power_status,
                              shutter_status: widget.projector.shutter_status,
                              connected: widget.projector.connected,
                              isOnHover: widget.projector.isOnHover,
                              lamp_hours: widget.projector.lamp_hours,
                              status: widget.projector.status,
                              color_state: widget.projector.color_state,
                            );
                            setState(() {
                              if (_formKey.currentState!.validate()) {
                                updateProjector(new_projector, widget.projectorKey);
                                Navigator.of(context).pop();
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
                            ],
                          ),
                        ),
                      ),
                    )),
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
    );
  }
}
