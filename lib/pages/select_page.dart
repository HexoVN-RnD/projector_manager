// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/pages/roomManager.dart';
import 'package:responsive_dashboard/pages/home_page.dart';
import 'package:responsive_dashboard/pages/page_2.dart';
import 'package:responsive_dashboard/pages/page_3.dart';
import 'package:responsive_dashboard/pages/squareMenu.dart';

class SelectPage extends StatefulWidget {
  // final int current_page;

  const SelectPage({
    Key key,
    // @required this.current_page,
  }) : super(key: key);

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  @override
  Widget build(BuildContext context) {
    // If our width is more than 1200 then we consider it a desktop
    if (current_page.getValue() == 0) {
      return HomePage();
    }
    // If width it less then 1200 and more then 768 we consider it as tablet
    else if (current_page.getValue() == 1) {
      return RoomManager();
    }
    // Or less then that we called it mobile
    else if (current_page.getValue() == 2) {
      return Page2();
    } else if (current_page.getValue() == 3) {
      return Page3();
    } else {
      return SideBar();
    }
  }
}
