import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Method/searchMethod.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';
import 'package:valuable/valuable.dart';

StatefulValuable<String> text_search = StatefulValuable<String>('');

class Header extends StatefulWidget {
  Room room;
  Header({
    required this.room,
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final text_controller =TextEditingController();

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
              Row(
                children: [
                  Icon(
                    Icons.door_sliding,
                    size: 25,
                    color: AppColors.gray,
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeVertical,
                  ),
                  PrimaryText(
                      text: name.toUpperCase(),
                      size: 30,
                      fontWeight: FontWeight.w800),
                ],
              ),
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
            controller: text_controller,
            onChanged: (value) {
              setState(() {
                text_search.setValue(value);
                if (value!='') {
                  Search(value);
                }
              });
            },
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
                prefixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        Search(text_search.getValue().toString());
                      });
                    },
                    child: Icon(Icons.search, color: AppColors.black)),
                hintText: 'Search',
                hintStyle: TextStyle(color: AppColors.secondary, fontSize: 14)),
          ),
        ),
      ),
    ]);
  }
}
