import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:responsive_dashboard/style/colors.dart';

class MyDropBar extends StatefulWidget {
  double? width = 400;
  double? height = 55;
  // TextEditingController textEditing;
  // String textLable;
  // String textHint;
  String dropdownMenu;
  String defaultValue;
  List<DropdownMenuItem<String>> items;
  Function(String?)? onChanged;

  MyDropBar({
    this.width,
    this.height,
    // required this.textEditing,
    // required this.textLable,
    // required this.textHint,
    required this.dropdownMenu,
    required this.defaultValue,
    required this.items,
    this.onChanged,
  });
  @override
  State<MyDropBar> createState() => _MyDropBarState();
}

class _MyDropBarState extends State<MyDropBar>
    with TickerProviderStateMixin {
  bool isShowSignInDialog = false;
  bool isChecked = false;
  bool isAccountCorrect = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: EdgeInsets.all(20),
      // padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButton<String>(

        hint: Text('Select type: '),
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        // dropdownColor: Colors.transparent,
        value: widget.dropdownMenu,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        isExpanded: true,
        style: TextStyle(color: AppColors.primary),
        borderRadius: BorderRadius.circular(20),
        underline: Container(),
        onChanged: widget.onChanged ?? (value){
          setState(() {
            widget.dropdownMenu = value?? widget.defaultValue;
          });
        },
        items: widget.items,
      ),
    );
  }
}
