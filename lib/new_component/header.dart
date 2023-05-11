import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

class Header extends StatefulWidget {
  Room room;
  Header({required this.room, });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {

  @override
  Widget build(BuildContext context) {
    String name = widget.room.name;
    String general = widget.room.general;
    return Row(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryText(
                  text: name.toUpperCase(),
                  size: 30,
                  fontWeight: FontWeight.w800),
              PrimaryText(
                text: general,
                size: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondary,
              )
            ]),
      ),
      Spacer(
        flex: 1,
      ),
      Expanded(
        flex: Responsive.isDesktop(context) ? 1 : 3,
        child: Container(
          width: 100,
          child: TextField(
            decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                contentPadding: EdgeInsets.only(left: 40.0, right: 5),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: AppColors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: AppColors.white),
                ),
                prefixIcon: Icon(Icons.search, color: AppColors.black),
                hintText: 'Search',
                hintStyle: TextStyle(color: AppColors.secondary, fontSize: 14)),
          ),
        ),
      ),
    ]);
  }
}
