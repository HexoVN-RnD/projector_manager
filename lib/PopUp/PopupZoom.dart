import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/PopUp/customRectTween.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/style/colors.dart';

const String heroZoom = 'popup-zoom';

/// {@template add_todo_popup_card}
/// Popup card to add a new [Todo]. Should be used in conjuction with
/// [HeroDialogRoute] to achieve the popup effect.
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class PopupZoom extends StatefulWidget {
  /// {@macro add_todo_popup_card}
  const PopupZoom({Key? key}) : super(key: key);

  @override
  State<PopupZoom> createState() => _PopupZoomState();
}

class _PopupZoomState extends State<PopupZoom> {
  @override
  Widget build(BuildContext context) {
    Room room =
    rooms[(current_page.getValue() > 0) ? current_page.getValue() - 1 : 1];
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: heroZoom,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },
          child: SingleChildScrollView(
            child: Container(
              width: SizeConfig.screenWidth - 80,
              height: (SizeConfig.screenWidth - 80)*1050/1920,
              decoration: BoxDecoration(
                  color: AppColors.gray,
                  borderRadius: BorderRadius.circular(30)),
              child: Stack(alignment: Alignment.topRight, children: [
                Container(
                  // width: SizeConfig.screenWidth - 80,
                  // height: (SizeConfig.screenWidth - 80)*1050/1920,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Transform.scale(
                          scale: 1,
                        child: Image.asset(
                          room.map,
                          fit: BoxFit.fill,
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white_trans,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        // print('check');
                        Navigator.of(context).pop();
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Icon(
                        Icons.zoom_out,
                        size: 25,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
