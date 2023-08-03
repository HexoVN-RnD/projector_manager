import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/new_component/animated_btn.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';
import 'package:rive/rive.dart';
import 'package:valuable/valuable.dart';

// StatefulValuable<double> opening_per = StatefulValuable<double>(0);

double progressValue = 0.0;
int half_length = (rooms[1].projectors.length/2).toInt()+1;

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
      duration: Duration(seconds: 60),
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
              padding: const EdgeInsets.only(top: 450.0),
              child: Image.asset(
                "assets/logo2.png",
                width: 600,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          // Positioned.fill(
          //   child: BackdropFilter(
          //     filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          //     child: const SizedBox(),
          //   ),
          // ),
          // const RiveAnimation.asset(
          //   "assets/RiveAssets/shapes.riv",
          // ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
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
                    // const Spacer(),
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: 260,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Hexogon",
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                              height: 1.2,
                            ),
                          ),
                          // SizedBox(height: 16),
                          Text('Please waiting for check connection'),
                          // Text('Contact: duyminh-vn@hexogonsol.com'),
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
                    const SizedBox(height: 50,),
                    // const Padding(
                    //   padding: EdgeInsets.symmetric(vertical: 24),
                    //   child: PrimaryText(
                    //       size: 14,
                    //       text:
                    //           'Purchase includes access to 30+ courses, 240+ premium tutorials, 120+ hours of videos, source files and certificates.'),
                    // )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 30,
            top: MediaQuery.of(context).size.height * 0.11,
            width: MediaQuery.of(context).size.width-80,
            height: MediaQuery.of(context).size.height,
            child:
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 60, 10, 10),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Column(
                        children:
                        List.generate(rooms[0].servers.length,
                                (index) {
                              Server server = rooms[0].servers[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 120,
                                      child: PrimaryText(
                                        text: '${server.name}',
                                        size: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 100,
                                      child: PrimaryText(
                                        text: '(${server.ip})',
                                        size: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    PrimaryText(
                                      text: server.connected.getValue()
                                          ? 'Connected'
                                          : 'Disconnect',
                                      color: server.connected.getValue()
                                          ? AppColors.green
                                          : AppColors.red,
                                      size: 14,
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                      SizedBox(height: 50,),
                      Column(
                        children:
                        List.generate(rooms[3].servers.length,
                                (index) {
                              Server server = rooms[0].servers[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 120,
                                      child: PrimaryText(
                                        text: '${server.name}',
                                        size: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 100,
                                      child: PrimaryText(
                                        text: '(${server.ip})',
                                        size: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    PrimaryText(
                                      text: server.connected.getValue()
                                          ? 'Connected'
                                          : 'Disconnect',
                                      color: server.connected.getValue()
                                          ? AppColors.green
                                          : AppColors.red,
                                      size: 14,
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: List.generate(
                          half_length, (index) {
                        Projector projector =
                        rooms[1].projectors[index];
                        return Padding(
                          padding:
                          const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 150,
                                child: PrimaryText(
                                  text: '${projector.name}',
                                  size: 14,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 100,
                                child: PrimaryText(
                                  text: '(${projector.ip})',
                                  size: 14,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              PrimaryText(
                                text: projector.connected.getValue()
                                    ? 'Connected'
                                    : 'Disconnect',
                                color: projector.connected.getValue()
                                    ? AppColors.green
                                    : AppColors.red,
                                size: 14,
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: List.generate(
                          rooms[1].projectors.length-half_length, (index) {
                        Projector projector =
                        rooms[1].projectors[index+half_length];
                        return Padding(
                          padding:
                          const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 150,
                                child: PrimaryText(
                                  text: '${projector.name}',
                                  size: 14,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 100,
                                child: PrimaryText(
                                  text: '(${projector.ip})',
                                  size: 14,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              PrimaryText(
                                text: projector.connected.getValue()
                                    ? 'Connected'
                                    : 'Disconnect',
                                color: projector.connected.getValue()
                                    ? AppColors.green
                                    : AppColors.red,
                                size: 14,
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  Column(
                      children: [
                        Column(
                          children: List.generate(
                              rooms[2].projectors.length, (index) {
                            Projector projector =
                            rooms[2].projectors[index];
                            return Padding(
                              padding:
                              const EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 150,
                                    child: PrimaryText(
                                      text: '${projector.name}',
                                      size: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 100,
                                    child: PrimaryText(
                                      text: '(${projector.ip})',
                                      size: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  PrimaryText(
                                    text: projector.connected.getValue()
                                        ? 'Connected'
                                        : 'Disconnect',
                                    color:
                                    projector.connected.getValue()
                                        ? AppColors.green
                                        : AppColors.red,
                                    size: 14,
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                        SizedBox(height: 50,),
                        Column(
                          children: List.generate(
                              rooms[3].projectors.length, (index) {
                            Projector projector =
                            rooms[3].projectors[index];
                            return Padding(
                              padding:
                              const EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 150,
                                    child: PrimaryText(
                                      text: '${projector.name}',
                                      size: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 100,
                                    child: PrimaryText(
                                      text: '(${projector.ip})',
                                      size: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  PrimaryText(
                                    text: projector.connected.getValue()
                                        ? 'Connected'
                                        : 'Disconnect',
                                    color:
                                    projector.connected.getValue()
                                        ? AppColors.green
                                        : AppColors.red,
                                    size: 14,
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ]),
                ],
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.3,
            bottom: 60,
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