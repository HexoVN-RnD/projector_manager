import 'package:flutter/material.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

class Header extends StatefulWidget {
  String name;
  String general;
  Header({
    @required this.name,
    @required this.general,
  });

  @override
  State<Header> createState() => _HeaderState(this.name, this.general);
}

class _HeaderState extends State<Header> {
  String name = rooms[current_page.getValue()-1].name;
  String general =rooms[current_page.getValue()-1].general;

  _HeaderState(String name, String general);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
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
        child: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            contentPadding:
                EdgeInsets.only(left: 40.0, right: 5),
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
            hintStyle: TextStyle(color: AppColors.secondary, fontSize: 14)
          ),
        ),
      ),
    ]);
  }
}
