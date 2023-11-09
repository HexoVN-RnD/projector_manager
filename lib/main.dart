// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SharedPreferences Demo',
      home: SharedPreferencesDemo(),
    );
  }
}

class SharedPreferencesDemo extends StatefulWidget {
  const SharedPreferencesDemo({key});

  @override
  SharedPreferencesDemoState createState() => SharedPreferencesDemoState();
}

class SharedPreferencesDemoState extends State<SharedPreferencesDemo> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('SharedPreferences Demo'),
      ),
      body: Center(
        //     child: Text(projector.toJson().toString()),
        // ),
          child: FutureBuilder<Projector>(
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
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: setNewProjector,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
//
// import 'package:firedart/firedart.dart';
// import 'package:flutter/material.dart';
// import 'package:responsive_dashboard/Method/openingCheck.dart';
// import 'package:responsive_dashboard/dashboard.dart';
// import 'package:responsive_dashboard/openingScene.dart';
// import 'package:responsive_dashboard/style/colors.dart';
// import 'package:window_manager/window_manager.dart';
//
// // const apiKey = 'AIzaSyDjq1K4uejMJbwp0qGYTLneOhiNm3H_KJc';
// const apiKey = 'AIzaSyBIJJfda5McG1_1DucYfVxwTdvZ9IozP7w';
// const projectId = 'toong-dd7c8';
// // const projectId = 'toong-23d79';
// // final FirebaseFirestore firestore = FirebaseFirestore.instance;
//
// Future<void> main() async {
//   // WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp(name: projectId);
//   Firestore.initialize(projectId);
//   // Firestore.initialize('toong-23d79');
//   WidgetsFlutterBinding.ensureInitialized();
//   await windowManager.ensureInitialized();
//
//   WindowOptions windowOptions = const WindowOptions(
//     title: 'Projector Manager',
//     size: Size(1920, 1050),
//     fullScreen: true,
//     minimumSize: Size(1920 , 1050),
//     center: true,
//     backgroundColor: Colors.transparent,
//     skipTaskbar: false,
//     titleBarStyle: TitleBarStyle.normal,
//     windowButtonVisibility: true,
//   );
//   windowManager.waitUntilReadyToShow(windowOptions, () async {
//     await windowManager.show();
//     await windowManager.focus();
//   });
//   runApp(MyApp());
//   OpeningCheck();
//   // SharedPreferences prefs = await SharedPreferences.getInstance();
// }
//
// class MyApp extends StatelessWidget {
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         scaffoldBackgroundColor: AppColors.primaryBg
//       ),
//       // home: Dashboard(),
//       home: OpeningScene(),
//     );
//   }
// }
