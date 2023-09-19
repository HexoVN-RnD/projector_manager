
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Method/openingCheck.dart';
import 'package:responsive_dashboard/openingScene.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:window_manager/window_manager.dart';

const apiKey = 'AIzaSyDjq1K4uejMJbwp0qGYTLneOhiNm3H_KJc';
const projectId = 'toong-23d79';
// final FirebaseFirestore firestore = FirebaseFirestore.instance;

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
      home: OpeningScene(),
    );
  }
}
