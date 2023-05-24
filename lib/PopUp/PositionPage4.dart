import 'package:flutter/cupertino.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/style/colors.dart';

class PositionPage4 extends StatefulWidget {
  Projector projector;
  double width;
  double height;
  PositionPage4({
    required this.projector,
    required this.width,
    required this.height,
  });

  @override
  State<PositionPage4> createState() => _PositionPage4State();
}

class _PositionPage4State extends State<PositionPage4> {
  @override
  Widget build(BuildContext context) {
    Projector projector = widget.projector;
    double width = widget.width;
    double height = widget.height;
    return Positioned(
      left: width * projector.position.dx,
      top: height * projector.position.dy,
      width: width * 0.0095,
      height: width * 0.0095,
      child: Container(
        color: projector.connected.getValue()
            ? (projector.power_status.getValue()
            ? AppColors.navy_blue
            : AppColors.red)
            : AppColors.gray,
      ),
    );
  }
}
