import 'dart:async';
import 'dart:ui';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firedart/firedart.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:responsive_dashboard/Method/Control_projector_void.dart';
import 'package:responsive_dashboard/Method/ping_check_connection.dart';
import 'package:responsive_dashboard/Method/projector_command.dart';
import 'package:responsive_dashboard/Object/Preset.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/Sensor.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/dashboard_ipad.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:responsive_dashboard/new_component/animated_btn.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';
import 'package:rive/rive.dart';
import 'package:valuable/valuable.dart';

// StatefulValuable<double> opening_per = StatefulValuable<double>(0);

double progressValue = 0.0;
// int half_length = (rooms[3].projectors.length / 2).toInt() + 1;

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
  bool isUsingKeyboard = false;
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
  List<Document> listIP = [];
  List<Document> listServer = [];

  Future<List<Document>> getAccount() async {
    account = await licenseCollection.orderBy('account').get();
    return account;
  }

  Future<List<Document>> getPassword() async {
    password = await licenseCollection.orderBy('password').get();
    return password;
  }

  Future<List<Document>> getIP() async {
    listIP = await Firestore.instance
        .collection('listProjectors')
        .orderBy('ip')
        .get();
    // print(listIP.length);
    if (listIP.length == 2) {
      rooms[0].projectors[0].ip = listIP[0]['ip'];
      rooms[0].projectors[1].ip = listIP[1]['ip'];
    }
    return password;
  }

  Future<List<Document>> getServer() async {
    final ip =
        await Firestore.instance.collection('listServers').orderBy('ip').get();
    final mac_address = await Firestore.instance
        .collection('listServers')
        .orderBy('mac_address')
        .get();
    // print(listIP.length);
    rooms[0].servers[0].ip = ip[0]['ip'];
    rooms[0].servers[0].mac_address = mac_address[0]['mac_address'];

    return password;
  }

  Future<List<Document>> getPreset() async {
    final querySnapshot =
        await Firestore.instance.collection('listPresets').get();

    rooms[0].presets = querySnapshot.map((doc) {
      return Preset(
        name: doc['name'] ?? 'Preset',
        image: doc['image'] ??
            'https://firebasestorage.googleapis.com/v0/b/ocbmanager-bc645.appspot.com/o/default.png?alt=media&token=1e5266f9-74a9-4bbb-a784-bbe29024e79b',
        osc_message: 'colume',
        transport: StatefulValuable<double>(0),
      );
    }).toList();
    print(rooms[0].presets.length);

    // rooms[0].servers[0].ip = ip[0]['ip'];
    // rooms[0].servers[0].mac_address = mac_address[0]['mac_address'];

    return password;
  }

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false,
    );
    getIP();
    getServer();
    getPreset();
    super.initState();
    // // Đăng ký lắng nghe sự kiện hiện/ẩn bàn phím
    // KeyboardVisibilityController().onChange.listen((bool visible) {
    //   isUsingKeyboard = visible;
    //   print(isUsingKeyboard);
    //   // Thực hiện hành động phù hợp
    // });
    // _timer = Timer.periodic(Duration(milliseconds: 3000), (timer) {
    //   checkAllRoomConnection(3000);
    // });
    _timer2 = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        checkAllRoomConnection(500);
      });
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
    // _timer?.cancel();
    _timer2?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          // Thiết bị đang ở chế độ xoay dọc
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    // top: MediaQuery.of(context).size.height*0.2,
                    // left: (MediaQuery.of(context).size.width-500)/2,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.15,
                          bottom: 150),
                      child: Image.asset(
                        "assets/LogoOCB.png",
                        height: 500 / 1200 * 450,
                        width: 500,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    // top: MediaQuery.of(context).size.width*0.3,
                    // left: MediaQuery.of(context).size.width * 0.25,
                    margin: EdgeInsets.only(bottom: 100),
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
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
                                  return 'Tài khoản không chính xác';
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'Tên đăng nhập...',
                                labelText: 'Tài khoản',
                                labelStyle:
                                    TextStyle(color: AppColors.navy_blue),
                                // prefixIcon: Icon(Icons.mail),
                                // icon: Icon(Icons.mail),
                                suffixIcon: accountController.text.isEmpty
                                    ? Container(width: 0)
                                    : IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () =>
                                            accountController.clear(),
                                      ),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.navy_blue),
                                    borderRadius: BorderRadius.circular(20)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.navy_blue,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
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
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: TextFormField(
                              validator: (value) {
                                // print('value: $value');
                                isPasswordCorrect = password.any((license) {
                                  final password =
                                      license['password'].toString();
                                  return password == value;
                                });
                                if (value == null || value.isEmpty) {
                                  return 'Hãy điền mật khẩu';
                                } else if (!isPasswordCorrect) {
                                  return 'Mật khẩu không chính xác';
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
                                labelStyle:
                                    TextStyle(color: AppColors.navy_blue),
                                // errorText: 'Vui lòng thử lại',
                                suffixIcon: IconButton(
                                  icon: isPasswordVisible
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                  onPressed: () => setState(() =>
                                      isPasswordVisible = !isPasswordVisible),
                                ),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.navy_blue),
                                    borderRadius: BorderRadius.circular(20)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.navy_blue,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              obscureText: isPasswordVisible,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // AnimatedBtn(
                          //   btnAnimationController: _btnAnimationController,
                          //   press: () async {
                          //     _btnAnimationController.isActive = true;
                          //     Navigator.of(context).pushReplacement(
                          //       MaterialPageRoute(
                          //           builder: (context) => DashboardIpad()),
                          //     );
                          //   },
                          // ),
                          isChecked
                              ? AnimatedBtn(
                                  btnAnimationController:
                                      _btnAnimationController,
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
                                        if (isAccountCorrect &&
                                            isPasswordCorrect) {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DashboardIpad()),
                                          );
                                        }
                                      },
                                    );
                                  },
                                )
                              : Container(
                                  height: 70,
                                  width: 100,
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
                  Container(
                    // left: MediaQuery.of(context).size.width * 0.2,
                    // top: MediaQuery.of(context).size.height * 0.75,
                    width: MediaQuery.of(context).size.width * 0.6,
                    // height: 100,
                    child: SafeArea(
                      child: Column(
                        children: [
                          Container(
                            height: 15,
                            margin: EdgeInsets.only(bottom: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: LinearProgressIndicator(
                                value: progressValue,
                                color: AppColors.navy_blue,
                                backgroundColor: AppColors.white,
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(bottom: 50),
                              child:
                                  Text('Please waiting for check connection')),
                          Column(
                              children: List.generate(
                                  rooms[0].projectors.length, (index) {
                            Projector projector = rooms[0].projectors[index];
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.6,
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
                                    width: 110,
                                    child: PrimaryText(
                                      text: '(${projector.ip})',
                                      size: 14,
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      width: 10,
                                    ),
                                  ),
                                  PrimaryText(
                                    text: projector.connected.getValue()
                                        ? 'Đã kết nối '
                                        : 'Mất kết nối',
                                    color: projector.connected.getValue()
                                        ? AppColors.green
                                        : AppColors.red,
                                    size: 14,
                                  )
                                ],
                              ),
                            );
                          })),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      // right: 30,
                      //   top: MediaQuery.of(context).size.height * 0.95,
                      margin: EdgeInsets.fromLTRB(0, 0, 30, 30),
                      alignment: Alignment.bottomRight,
                      child: Text('@Designed by HexogonVN'))
                ],
              ),
            ),
          );
        } else {
          // Thiết bị đang ở chế độ xoay ngang
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    // top: MediaQuery.of(context).size.height*0.2,
                    // left: (MediaQuery.of(context).size.width-500)/2,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1,
                          bottom: 80),
                      child: Image.asset(
                        "assets/LogoOCB.png",
                        height: 400 / 1200 * 450,
                        width: 400,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      // top: MediaQuery.of(context).size.width*0.3,
                      // left: MediaQuery.of(context).size.width * 0.25,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 40),
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: TextFormField(
                                controller: accountController,
                                validator: (value) {
                                  isAccountCorrect = account.any((license) {
                                    final account =
                                        license['account'].toString();
                                    return account == accountController.text;
                                  });
                                  if (value == null || value.isEmpty) {
                                    return 'Hãy điền tài khoản';
                                  } else if (!isAccountCorrect) {
                                    return 'Tài khoản không chính xác';
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'Tên đăng nhập...',
                                  labelText: 'Tài khoản',
                                  labelStyle:
                                      TextStyle(color: AppColors.navy_blue),
                                  // prefixIcon: Icon(Icons.mail),
                                  // icon: Icon(Icons.mail),
                                  suffixIcon: accountController.text.isEmpty
                                      ? Container(width: 0)
                                      : IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: () =>
                                              accountController.clear(),
                                        ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.navy_blue),
                                      borderRadius: BorderRadius.circular(20)),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.navy_blue,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
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
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: TextFormField(
                                validator: (value) {
                                  // print('value: $value');
                                  isPasswordCorrect = password.any((license) {
                                    final password =
                                        license['password'].toString();
                                    return password == value;
                                  });
                                  if (value == null || value.isEmpty) {
                                    return 'Hãy điền mật khẩu';
                                  } else if (!isPasswordCorrect) {
                                    return 'Mật khẩu không chính xác';
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
                                  labelStyle:
                                      TextStyle(color: AppColors.navy_blue),
                                  // errorText: 'Vui lòng thử lại',
                                  suffixIcon: IconButton(
                                    icon: isPasswordVisible
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility),
                                    onPressed: () => setState(() =>
                                        isPasswordVisible = !isPasswordVisible),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.navy_blue),
                                      borderRadius: BorderRadius.circular(20)),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.navy_blue,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                obscureText: isPasswordVisible,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            isChecked
                                ? AnimatedBtn(
                                    btnAnimationController:
                                        _btnAnimationController,
                                    press: () async {
                                      _btnAnimationController.isActive = true;
                                      getAccount();
                                      getPassword();
                                      getIP();
                                      getServer();
                                      getPreset();
                                      // print("isAccountCorrect: $isAccountCorrect ");
                                      Future.delayed(
                                        const Duration(milliseconds: 1000),
                                        () {
                                          setState(() {
                                            isShowSignInDialog = true;
                                          });
                                          if (_formKey.currentState!
                                              .validate()) {
                                            // The passwords match, you can proceed
                                            // For example, save the password to Firebase
                                            // Or navigate to another screen
                                          }
                                          if (isAccountCorrect &&
                                              isPasswordCorrect) {
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DashboardIpad()),
                                            );
                                          }
                                        },
                                      );
                                    },
                                  )
                                : Container(
                                    height: 70,
                                    width: 100,
                                  ),
                            // const SizedBox(
                            //   height: 50,
                            // ),
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
                  // Expanded(child: SizedBox()),
                  Container(
                    // left: MediaQuery.of(context).size.width * 0.2,
                    // top: MediaQuery.of(context).size.height * 0.75,
                    width: MediaQuery.of(context).size.width * 0.5,
                    // height: 100,
                    child: SafeArea(
                      child: Column(
                        children: [
                          Container(
                            height: 15,
                            margin: EdgeInsets.only(bottom: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: LinearProgressIndicator(
                                value: progressValue,
                                color: AppColors.navy_blue,
                                backgroundColor: AppColors.white,
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(bottom: 30),
                              child:
                                  Text('Please waiting for check connection')),
                          Column(
                              children: List.generate(
                                  rooms[0].projectors.length, (index) {
                            Projector projector = rooms[0].projectors[index];
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.6,
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
                                    width: 110,
                                    child: PrimaryText(
                                      text: '(${projector.ip})',
                                      size: 14,
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      width: 10,
                                    ),
                                  ),
                                  PrimaryText(
                                    text: projector.connected.getValue()
                                        ? 'Đã kết nối '
                                        : 'Mất kết nối',
                                    color: projector.connected.getValue()
                                        ? AppColors.green
                                        : AppColors.red,
                                    size: 14,
                                  )
                                ],
                              ),
                            );
                          })),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      // right: 30,
                      //   top: MediaQuery.of(context).size.height * 0.95,
                      alignment: Alignment.bottomRight,
                      margin: EdgeInsets.only(right: 30, bottom: 30),
                      child: Text('@Designed by HexogonVN')),
                  if (isUsingKeyboard)
                    SizedBox(
                      height: 300,
                    ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
