import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Method/Control_all_projectors_void.dart';
import 'package:responsive_dashboard/Method/Osc_void.dart';
import 'package:responsive_dashboard/Method/server_void.dart';
import 'package:responsive_dashboard/PopUp/customRectTween.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/pages/home_page.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

const String heroOffServer = 'add-off-server';

/// {@template add_todo_popup_card}
/// Popup card to add a new [Todo]. Should be used in conjuction with
/// [HeroDialogRoute] to achieve the popup effect.
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class PopupOffServer extends StatefulWidget {
  /// {@macro add_todo_popup_card}
  final VoidCallback? onUpdateState;
  const PopupOffServer({
    Key? key,
    this.onUpdateState,
  }) : super(key: key);

  @override
  State<PopupOffServer> createState() => _PopupOffServerState();
}

class _PopupOffServerState extends State<PopupOffServer> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: heroOffServer,
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin, end: end);
        },
        child: Material(
          color: AppColors.white,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          child: Container(
            width: 450,
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                    child: PrimaryText(
                      text: 'Bạn chắc chắn muốn tắt toàn bộ servers?',
                      size: 16,
                      color: AppColors.gray,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 50,
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.gray,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                Navigator.of(context).pop();
                              });
                            },
                            child: PrimaryText(
                              text: 'Huỷ'.toUpperCase(),
                              size: 14,
                              color: AppColors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 50,
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                StopAllPreset();
                                ShutdownAllServer();
                                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));
                                Navigator.of(context).pop();
                                widget.onUpdateState?.call();
                              });
                            },
                            child: PrimaryText(
                              text: 'Tắt'.toUpperCase(),
                              size: 14,
                              color: AppColors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
