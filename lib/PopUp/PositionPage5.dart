import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/style/colors.dart';

class PositionPage5 extends StatefulWidget {
  Projector projector;
  double width;
  double height;
  PositionPage5({
    required this.projector,
    required this.width,
    required this.height,
  });

  @override
  State<PositionPage5> createState() => _PositionPage5State();
}

class _PositionPage5State extends State<PositionPage5> {
  @override
  Widget build(BuildContext context) {
    Projector projector = widget.projector;
    double width = widget.width;
    double height = widget.height;
    return Positioned(
      left: width * projector.position.dx,
      top: height * projector.position.dy,
      width: width * 0.018,
      height: width * 0.018,
      child: Container(
        decoration: BoxDecoration(
            color: projector.connected.getValue()
                ? (projector.power_status.getValue()
                ? AppColors.navy_blue
                : AppColors.red)
                : AppColors.gray,
            border: projector.isOnHover.getValue()
                ? Border.all(
              strokeAlign: BorderSide.strokeAlignCenter,
              color:  projector.connected.getValue()
                  ? (projector.power_status.getValue()
                  ? AppColors.navy_blue
                  : AppColors.red)
                  : AppColors.gray,
              width: 4.0,
            )
                : Border.all(
              color:  Colors.transparent,
              width: 0.0,
            )),
      ),
    );
  }
}
