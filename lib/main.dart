import 'dart:io';

import 'package:dart_ping_ios/dart_ping_ios.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Method/openingCheck.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/openingScene.dart';
import 'package:responsive_dashboard/style/colors.dart';
// import 'package:window_manager/window_manager.dart';

// const apiKey = 'AIzaSyDzdBNoEyJZUxOZYibeT6X_aw0HdP24wUs';
// const apiKey = 'AIzaSyBIJJfda5McG1_1DucYfVxwTdvZ9IozP7w';
const projectId = 'ocbmanager-bc645';
// const projectId = 'toong-23d79';
// final FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(name: projectId);
  if (Platform.isIOS) {
    DartPingIOS.register();
  }
  WidgetsFlutterBinding.ensureInitialized();
  // Firestore.initialize(projectId);
  // Firebase.initializeApp(
  //     options: // For Firebase JS SDK v7.20.0 and later, measurementId is optional
  //         FirebaseOptions(
  //             apiKey: "AIzaSyAX0x4vr3GXjpCEDV5_9h8wsaIjeo70I48",
  //             authDomain: "ocbmanager-bc645.firebaseapp.com",
  //             projectId: "ocbmanager-bc645",
  //             storageBucket: "ocbmanager-bc645.appspot.com",
  //             messagingSenderId: "493715714638",
  //             appId: "1:493715714638:web:fe64ea9881f6f4677ac91f",
  //             measurementId: "G-XQ4LBGPT2R")
  //           );
  OpeningCheck();
  // Firestore.initialize('toong-23d79');
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
          scaffoldBackgroundColor: AppColors.primaryBg),
      // home: Dashboard(),
      home: OpeningScene(),
    );
  }
}
