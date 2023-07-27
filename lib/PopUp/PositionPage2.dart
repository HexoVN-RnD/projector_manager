import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/style/colors.dart';

class PositionPage2 extends StatefulWidget {
  Server server;
  double width;
  double height;
  PositionPage2({
    required this.server,
    required this.width,
    required this.height,
  });

  @override
  State<PositionPage2> createState() => _PositionPage2State();
}

class _PositionPage2State extends State<PositionPage2> {
  @override
  Widget build(BuildContext context) {
    Server server = widget.server;
    double width = widget.width;
    double height = widget.height;
    return Positioned(
      left: width * server.position.dx,
      top: height * server.position.dy,
      width: width * 0.009,
      height: height * 0.09,
      child: Container(
        // color:
        //     server.connected.getValue() ? AppColors.navy_blue : AppColors.gray,
        decoration: BoxDecoration(
            color: server.connected.getValue() ? AppColors.navy_blue : AppColors.gray,
            border: server.isOnHover.getValue()
                ? Border.all(
              strokeAlign: BorderSide.strokeAlignCenter,
              color:  server.connected.getValue() ? AppColors.navy_blue : AppColors.gray,
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