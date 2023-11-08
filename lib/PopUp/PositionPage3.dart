import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/style/colors.dart';

class PositionPage3 extends StatefulWidget {
  Projector projector;
  double width;
  double height;
  PositionPage3({
    required this.projector,
    required this.width,
    required this.height,
  });

  @override
  State<PositionPage3> createState() => _PositionPage3State();
}

class _PositionPage3State extends State<PositionPage3> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Projector projector = widget.projector;
    double width = widget.width;
    double height = widget.height;
    return Positioned(
      left: width * projector.position.dx,
      top: height * projector.position.dy,
      // left: width * 0.2295,
      // top: height * 0.15,
      width: width * 0.02,
      height: width * 0.02,
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.StatusColor[projector.status],
            border: projector.isOnHover
                ? Border.all(
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: AppColors.StatusColor[projector.status],
                    width: 4.0,
                  )
                : Border.all(
                    color: Colors.transparent,
                    width: 0.0,
                  )),
      ),
    );
  }
}
