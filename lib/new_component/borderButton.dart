import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Method/Control_all_projectors_void.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

class BorderButton extends StatefulWidget {
  late Color backgroundColor = AppColors.gray;
  late Color textColor = AppColors.white;
  double height = 40;
  double width = 60;
  double textSize = 14;
  late String text;
  double radius = 20;
  FontWeight fontWeight = FontWeight.w500;

  BorderButton({required this.text});

  @override
  _BorderButtonState createState() => _BorderButtonState();
}

class _BorderButtonState extends State<BorderButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.radius),
          ),
        ),
        onPressed: () {
          setState(() {
          });
        },
        child: PrimaryText(
          text: widget.text,
          size: widget.textSize,
          color: widget.textColor,
          fontWeight: widget.fontWeight,
        ),
      ),
    );
  }
}
