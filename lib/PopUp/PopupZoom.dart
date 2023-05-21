import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/PopUp/customRectTween.dart';
import 'package:responsive_dashboard/config/responsive.dart';
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
    final width = Responsive.isDesktop(context)
        ? SizeConfig.screenWidth - 200
        : SizeConfig.screenWidth - 60;
    final height = width * 1050 / 1920;
    return Center(
      child: Hero(
        tag: heroZoom,
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin, end: end);
        },
        child: SingleChildScrollView(
          child: Container(
            width: width,
            height: height,
            // decoration: BoxDecoration(
            //     color: AppColors.gray,
            //     borderRadius: BorderRadius.circular(30)),
            child: Stack(alignment: Alignment.topRight, children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    room.map,
                    fit: BoxFit.fill,
                  )),
              Padding(
                // padding: EdgeInsets.only(left: width-10,bottom: height-10),
                padding:
                    EdgeInsets.only(left: width - 100, bottom: height - 100),
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
              if (current_page.getValue() == 2)
                Stack(
                  children: List.generate(
                    room.projectors.length,
                    (index) => Positioned(
                      left: width * room.projectors[index].position.dx,
                      top: height * room.projectors[index].position.dy,
                      width: width * 0.0095,
                      height: width * 0.0095,
                      child: Container(
                        color: AppColors.navy_blue,
                      ),
                    ),
                  ),
                )
              else if (current_page.getValue() == 3)
                Stack(
                  children: List.generate(
                    room.projectors.length,
                    (index) => Positioned(
                      left: width * room.projectors[index].position.dx,
                      top: height * room.projectors[index].position.dy,
                      width: width * 0.018,
                      height: width * 0.018,
                      child: Container(
                        color: AppColors.navy_blue,
                      ),
                    ),
                  ),
                )
              else if (current_page.getValue() == 4)
                Stack(
                  children: List.generate(
                    room.projectors.length,
                    (index) => Positioned(
                      left: width * room.projectors[index].position.dx,
                      top: height * room.projectors[index].position.dy,
                      width: width * 0.012,
                      height: width * 0.012,
                      child: Container(
                        color: AppColors.navy_blue,
                      ),
                    ),
                  ),
                )
              else if (current_page.getValue() == 1)
                Stack(
                  children: List.generate(
                    room.servers.length,
                    (index) => Positioned(
                      left: width * room.servers[index].position.dx,
                      top: height * room.servers[index].position.dy,
                      width: width * 0.009,
                      height: height * 0.09,
                      child: Container(
                        color: AppColors.navy_blue,
                      ),
                    ),
                  ),
                ),
            ]),
          ),
        ),
      ),
    );
  }
}
