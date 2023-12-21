
import 'dart:io';

import 'package:dart_ping_ios/dart_ping_ios.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Method/openingCheck.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/openingScene.dart';
import 'package:responsive_dashboard/style/colors.dart';
// import 'package:window_manager/window_manager.dart';

const apiKey = 'AIzaSyDzdBNoEyJZUxOZYibeT6X_aw0HdP24wUs';
// const apiKey = 'AIzaSyBIJJfda5McG1_1DucYfVxwTdvZ9IozP7w';
const projectId = 'controlocb-a9490';
// const projectId = 'toong-23d79';
// final FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(name: projectId);
  if (Platform.isIOS) {
    DartPingIOS.register();
  }
  Firestore.initialize(projectId);
  // Firestore.initialize('toong-23d79');
  WidgetsFlutterBinding.ensureInitialized();
  // await windowManager.ensureInitialized();

  // WindowOptions windowOptions = const WindowOptions(
  //   title: 'Projector Manager',
  //   size: Size(1920, 1050),
  //   fullScreen: true,
  //   minimumSize: Size(1920 , 1050),
  //   center: true,
  //   backgroundColor: Colors.transparent,
  //   skipTaskbar: false,
  //   titleBarStyle: TitleBarStyle.normal,
  //   windowButtonVisibility: true,
  // );
  // windowManager.waitUntilReadyToShow(windowOptions, () async {
  //   await windowManager.show();
  //   await windowManager.focus();
  // });
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
