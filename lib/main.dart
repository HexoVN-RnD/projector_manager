// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
//
// ignore_for_file: public_member_api_docs


import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Method/openingCheck.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/openingScene.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

// const apiKey = 'AIzaSyDjq1K4uejMJbwp0qGYTLneOhiNm3H_KJc';
// const apiKey = 'AIzaSyBIJJfda5McG1_1DucYfVxwTdvZ9IozP7w';
const projectId = 'toong-dd7c8';
// const projectId = 'toong-23d79';
// final FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<SharedPreferences> prefs = SharedPreferences.getInstance();

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(name: projectId);
  Firestore.initialize(projectId);
  // Firestore.initialize('toong-23d79');
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    title: 'Projector Manager',
    size: Size(1920, 1050),
    fullScreen: true,
    minimumSize: Size(1920 , 1050),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    windowButtonVisibility: true,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(MyApp());
  OpeningCheck();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: AppColors.primaryBg
      ),
      // home: Dashboard(),
      home: OpeningScene(),
    );
  }
}

Future<void> clearSharedPreferences() async {
  final SharedPreferences new_prefs = await prefs;
  new_prefs.clear();
  print('SharedPreferences cleared.');
}
