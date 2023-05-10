import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_dashboard/Method/ping_check_connection.dart';
import 'package:responsive_dashboard/Method/projector_cmd.dart';
import 'package:responsive_dashboard/Object/Preset.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';
import 'package:auto_reload/auto_reload.dart';

class PresetWidget extends StatefulWidget {
  Preset preset;
  Room room;
  int index;

  PresetWidget({@required this.room, @required this.preset,@required this.index});

  @override
  State<PresetWidget> createState() => _PresetWidgetState();
}

class _PresetWidgetState extends State<PresetWidget> {

  @override
  Widget build(BuildContext context) {
    bool isSelected = widget.room.current_preset.getValue() == widget.index;
    return GestureDetector(
        onTap: () {
          // refreshList();
          // double_refreshList();
          setState(() {
            widget.room.current_preset.setValue(widget.index);
            print(widget.room.current_preset.getValue());
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              width: isSelected ? 180.0 : 120.0,
              height: isSelected ? 180.0 : 120.0,
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.navy_blue : AppColors.black,
                borderRadius: BorderRadius.circular(isSelected ? 20.0 : 15),
              ),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Image.asset(widget.preset.image),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_balance,
                      size: isSelected ? 26 : 15,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
                    PrimaryText(
                        text:
                        widget.preset.name,
                        size: isSelected ? 17 : 12,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600),
                  ],
                ),
                SizedBox(height: SizeConfig.blockSizeVertical),
                if (isSelected)
                  PrimaryText(
                      text: widget.preset.transport.getValue().toString(),
                      size: 12,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500),
              ],
            ),
          ],
        ));
  }
}
