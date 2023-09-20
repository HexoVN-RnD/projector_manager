import 'dart:async';
import 'dart:ui';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firedart/firedart.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:responsive_dashboard/Method/Control_projector_void.dart';
import 'package:responsive_dashboard/Method/ping_check_connection.dart';
import 'package:responsive_dashboard/Method/projector_command.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/Sensor.dart';
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
int half_length = (rooms[3].projectors.length / 2).toInt() + 1;

class OpeningScene extends StatefulWidget {
  const OpeningScene({key});

  @override
  State<OpeningScene> createState() => _OpeningSceneState();
}

class _OpeningSceneState extends State<OpeningScene>
    with TickerProviderStateMixin {
  late RiveAnimationController _btnAnimationController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Timer? _timer;
  Timer? _timer2;
  bool isShowSignInDialog = false;
  bool isChecked = false;
  late AnimationController _animationController;

  final accountController = TextEditingController();
  final passwordController = TextEditingController();
  // String password = '';
  bool isPasswordVisible = true;
  bool isAccountCorrect = false;
  bool isPasswordCorrect = false;
  CollectionReference licenseCollection =
      Firestore.instance.collection('license');
  List<Document> account = [];
  List<Document> password = [];

  Future<List<Document>> getAccount() async {
    account = await licenseCollection.orderBy('account').get();
    return account;
  }

  Future<List<Document>> getPassword() async {
    password = await licenseCollection.orderBy('password').get();
    return password;
  }

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 3000), (timer) {
      checkAllRoomConnection(3000);
    });
    _timer2 = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {});
    });
    _animationController = AnimationController(
      duration: Duration(seconds: 15),
      vsync: this,
    )..addListener(() {
        setState(() {
          progressValue = _animationController.value;
          if (progressValue == 1) {
            isChecked = true;
          }
        });
      });
    _animationController.forward();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer2?.cancel();
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
            // top: isShowSignInDialog ? -50 : 0,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            duration: const Duration(milliseconds: 260),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Form(
                  key: _formKey,
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
                      const Spacer(flex: 5),

                      Container(
                        width: 300,
                        child: TextFormField(
                          controller: accountController,
                          validator: (value) {
                            isAccountCorrect = account.any((license) {
                              final account = license['account'].toString();
                              return account == accountController.text;
                            });
                            if (value == null || value.isEmpty) {
                              return 'Hãy điền tài khoản';
                            } else if (!isAccountCorrect) {
                              return 'Tài khoản không chính xác hoặc license đã hết hạn';
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Tên đăng nhập...',
                            labelText: 'Tài khoản',
                            // prefixIcon: Icon(Icons.mail),
                            // icon: Icon(Icons.mail),
                            suffixIcon: accountController.text.isEmpty
                                ? Container(width: 0)
                                : IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () => accountController.clear(),
                                  ),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.navy_blue),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          // autofocus: true,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 300,
                        child: TextFormField(
                          validator: (value) {
                            // print('value: $value');
                            isPasswordCorrect = password.any((license) {
                              final password = license['password'].toString();
                              return password == value;
                            });
                            if (value == null || value.isEmpty) {
                              return 'Hãy điền mật khẩu';
                            } else if (!isPasswordCorrect) {
                              return 'Mật khẩu không chính xác hoặc license đã hết hạn';
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              // print('value: $value');
                              // passwordController.text = value;
                            });
                          },
                          controller: passwordController,
                          // onChanged: (value) => setState(() => this.password = value),
                          // onSubmitted: (value) => setState(() => this.password = value),
                          decoration: InputDecoration(
                            hintText: 'Mật khẩu...',
                            labelText: 'Mật khẩu',
                            // errorText: 'Vui lòng thử lại',
                            suffixIcon: IconButton(
                              icon: isPasswordVisible
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              onPressed: () => setState(
                                  () => isPasswordVisible = !isPasswordVisible),
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.navy_blue),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          obscureText: isPasswordVisible,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Container(
                      //   height: 100,
                      //   width: 200,
                      //   child: FutureBuilder<List<Document>>(
                      //     future: getAccount(),
                      //     builder: (BuildContext context,
                      //         AsyncSnapshot<List<Document>> snapshot) {
                      //       if (!snapshot.hasData) {
                      //         return const Center(child: Text('Loading...'));
                      //       }
                      //       return snapshot.data!.isEmpty
                      //           ? const Center(child: Text('No account in List'))
                      //           : ListView(
                      //         children: snapshot.data!.map((license) {
                      //           return Text(license['account'].toString());// ListTile
                      //         }).toList(),
                      //       );
                      //     },
                      //   ),
                      // ), //

                      AnimatedBtn(
                        btnAnimationController: _btnAnimationController,
                        press: () async {
                          _btnAnimationController.isActive = true;
                          // getAccount();
                          // getPassword();
                          // isAccountCorrect = account.any((license) {
                          //   final account = license['account'].toString();
                          //   return account == accountController.text;
                          // });
                          // isPasswordCorrect = password.any((license) {
                          //   final password = license['password'].toString();
                          //   return password == passwordController.text;
                          // });
                          getAccount();
                          // print('account: ${account}');
                          getPassword();
                          // print("isAccountCorrect: $isAccountCorrect ");
                          Future.delayed(
                            const Duration(milliseconds: 1000),
                            () {
                              setState(() {
                                isShowSignInDialog = true;
                              });
                              if (_formKey.currentState!.validate()) {
                                // The passwords match, you can proceed
                                // For example, save the password to Firebase
                                // Or navigate to another screen
                              }
                              if (isAccountCorrect && isPasswordCorrect) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => Dashboard()),
                                );
                              }
                            },
                          );
                        },
                      ),
                      isChecked
                          ? AnimatedBtn(
                              btnAnimationController: _btnAnimationController,
                        press: () async {
                          _btnAnimationController.isActive = true;
                          // getAccount();
                          // getPassword();
                          // isAccountCorrect = account.any((license) {
                          //   final account = license['account'].toString();
                          //   return account == accountController.text;
                          // });
                          // isPasswordCorrect = password.any((license) {
                          //   final password = license['password'].toString();
                          //   return password == passwordController.text;
                          // });
                          getAccount();
                          getPassword();
                          // print("isAccountCorrect: $isAccountCorrect ");
                          Future.delayed(
                            const Duration(milliseconds: 1000),
                                () {
                              setState(() {
                                isShowSignInDialog = true;
                              });
                              if (_formKey.currentState!.validate()) {
                                // The passwords match, you can proceed
                                // For example, save the password to Firebase
                                // Or navigate to another screen
                              }
                              if (isAccountCorrect && isPasswordCorrect) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => Dashboard()),
                                );
                              }
                            },
                          );
                        },
                            )
                          : Container(
                              height: 64,
                            ),
                      const SizedBox(
                        height: 50,
                      ),
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
          ),
          Positioned(
            left: 30,
            top: MediaQuery.of(context).size.height * 0.11,
            width: MediaQuery.of(context).size.width - 80,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 60, 10, 10),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children:
                        List.generate(rooms[2].projectors.length, (index) {
                      Projector projector = rooms[2].projectors[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                  ? 'Đã kết nối '
                                  : 'Mất kết nối',
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
                  Expanded(
                    child: Column(
                      children: List.generate(half_length, (index) {
                        Projector projector = rooms[3].projectors[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                    ? 'Đã kết nối '
                                    : 'Mất kết nối',
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
                          rooms[3].projectors.length - half_length, (index) {
                        Projector projector =
                            rooms[3].projectors[index + half_length];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                    ? 'Đã kết nối '
                                    : 'Mất kết nối',
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
                  Column(children: [
                    Column(
                      children:
                          List.generate(rooms[4].projectors.length, (index) {
                        Projector projector = rooms[4].projectors[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                    ? 'Đã kết nối '
                                    : 'Mất kết nối',
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
                    SizedBox(
                      height: 50,
                    ),
                    Column(
                      children:
                          List.generate(rooms[5].projectors.length, (index) {
                        Projector projector = rooms[5].projectors[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                    ? 'Đã kết nối '
                                    : 'Mất kết nối',
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
                  ]),
                ],
              ),
            ),
          ),
          Positioned(
            left: 30,
            top: 220,
            width: MediaQuery.of(context).size.width - 80,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 60, 10, 10),
              child: Column(
                children: [
                  Column(
                    children: List.generate(rooms[1].servers.length, (index) {
                      Server server = rooms[1].servers[index];
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
                                  ? 'Đã kết nối '
                                  : 'Mất kết nối',
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
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: List.generate(rooms[5].servers.length, (index) {
                      Server server = rooms[5].servers[index];
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
                                  ? 'Đã kết nối '
                                  : 'Mất kết nối',
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
                  SizedBox(
                    height: 50,
                  ),
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
