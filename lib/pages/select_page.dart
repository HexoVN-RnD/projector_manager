import 'package:flutter/material.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/pages/roomManager.dart';
import 'package:responsive_dashboard/pages/home_page.dart';
class SelectPage extends StatefulWidget {
  // final int current_page;

  const SelectPage({
    Key? key,
    // @required this.current_page,
  }) : super(key: key);

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  @override
  Widget build(BuildContext context) {
    if (current_page.getValue() == 0 && rooms.length > 1) {
      return HomePage();
    }
    else {
      return RoomManager();
    }
  }
}
