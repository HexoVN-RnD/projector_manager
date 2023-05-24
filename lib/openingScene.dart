import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/new_component/animated_btn.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';
import 'package:rive/rive.dart';
import 'package:valuable/valuable.dart';

// StatefulValuable<double> opening_per = StatefulValuable<double>(0);

double progressValue = 0.0;

class OpeningScene extends StatefulWidget {
  const OpeningScene({key});

  @override
  State<OpeningScene> createState() => _OpeningSceneState();
}

class _OpeningSceneState extends State<OpeningScene>
    with TickerProviderStateMixin {
  late RiveAnimationController _btnAnimationController;

  bool isShowSignInDialog = false;
  late AnimationController _animationController;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 15),
      vsync: this,
    )..addListener(() {
        setState(() {
          progressValue = _animationController.value;
          if (progressValue == 1) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Dashboard()));
          }
        });
      });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(200.0),
              child: Image.asset(
                "assets/logo2.png",
              ),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: const SizedBox(),
            ),
          ),
          // const RiveAnimation.asset(
          //   "assets/RiveAssets/shapes.riv",
          // ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox(),
            ),
          ),
          AnimatedPositioned(
            top: isShowSignInDialog ? -50 : 0,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            duration: const Duration(milliseconds: 260),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: 260,
                      child: Column(
                        children: const [
                          Text(
                            "Hexogon",
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text('@Designed by Duy Minh'),
                          Text('Contact: duyminh-vn@hexogonsol.com'),
                        ],
                      ),
                    ),
                    const Spacer(flex: 4),
                    AnimatedBtn(
                      btnAnimationController: _btnAnimationController,
                      press: () {
                        _btnAnimationController.isActive = true;

                        Future.delayed(
                          const Duration(milliseconds: 800),
                          () {
                            setState(() {
                              isShowSignInDialog = true;
                            });
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => Dashboard()),
                            );
                          },
                        );
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: PrimaryText(
                          text:
                              'Purchase includes access to 30+ courses, 240+ premium tutorials, 120+ hours of videos, source files and certificates.'),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.3,
            bottom: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.025,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: LinearProgressIndicator(
                value: progressValue,
                color: AppColors.navy_blue,
                backgroundColor: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
