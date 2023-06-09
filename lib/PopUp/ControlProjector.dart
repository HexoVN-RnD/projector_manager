import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/PopUp/customRectTween.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/style/colors.dart';

/// {@template add_todo_popup_card}
/// Popup card to add a new [Todo]. Should be used in conjuction with
/// [HeroDialogRoute] to achieve the popup effect.
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class ControlProjector extends StatefulWidget {
  /// {@macro add_todo_popup_card}
  Projector projector;
  ControlProjector({
    required this.projector,
  });

  @override
  State<ControlProjector> createState() => _ControlProjectorState();
}

class _ControlProjectorState extends State<ControlProjector> {
  @override
  Widget build(BuildContext context) {
    Projector projector = widget.projector;
    final width = Responsive.isDesktop(context)
        ? SizeConfig.screenWidth - 200
        : SizeConfig.screenWidth - 60;
    final height = width * 1050 / 1920;
    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}
