import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
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
class PopupAddProjectorNew extends StatefulWidget {
  /// {@macro add_todo_popup_card}

  @override
  State<PopupAddProjectorNew> createState() => _PopupAddProjectorNewState();
}

class _PopupAddProjectorNewState extends State<PopupAddProjectorNew> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
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
    final SharedPreferences prefs = await _prefs;
    final String? jsonString = prefs.getString(key);
    if (jsonString != null) {
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      return Projector.fromJson(jsonMap);
    } else {
      return default_projector;
    }
  }

  Future<void> setNewProjector() async {
    final SharedPreferences prefs = await _prefs;
    final Projector new_projector = Projector(
        ip: '192.168.3.3',
        name: 'Christie',
        port: 3002,
        UsernameAndPassword: 'admin',
        type: 'PJLink',
        power_status_button: false,
        shutter_status_button: false,
        power_status: false,
        shutter_status: false,
        lamp_hours: 0,
        status: 0,
        connected: false,
        position_x: 0.0,
        position_y: 0.0,
        color_state: false,
        isOnHover: false);

    setState(() {
      projector = Future.value(new_projector);
      prefs.setString('projector_1', json.encode(new_projector.toJson()));
    });
  }

  @override
  void initState() {
    super.initState();
    // projector = default_projector;
    projector = getProjector('projector_1');
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
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(30)),
              child: Stack(
                  children: [
                FutureBuilder<Projector>(
                    future: projector,
                    builder: (BuildContext context,
                        AsyncSnapshot<Projector> projector_snapshot) {
                      switch (projector_snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return const CircularProgressIndicator();
                        case ConnectionState.active:
                        case ConnectionState.done:
                          if (projector_snapshot.hasError) {
                            return Text('Error: ${projector_snapshot.error}');
                          } else {
                            return Text(
                              '${projector_snapshot.data?.toJson().toString()}',
                            );
                          }
                      }
                    }),
                Positioned(
                  bottom: 0
                  ,
                  child: GestureDetector(
                    onTap: setNewProjector,
                    child: Container(
                      width: 100,
                      height: 50,
                      child: Icon(Icons.add),
                    ),
                  ),
                ),
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
