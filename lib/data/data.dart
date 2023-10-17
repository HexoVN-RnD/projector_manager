import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Led.dart';
import 'package:responsive_dashboard/Object/Preset.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/Sensor.dart';
import 'package:responsive_dashboard/Object/Server.dart';
// import 'package:responsive_dashboard/Object/Test_Pattern.dart';
import 'package:responsive_dashboard/Object/allRoom.dart';
import 'package:responsive_dashboard/Object/rive_model.dart';
import 'package:responsive_dashboard/data/menu.dart';
import 'package:valuable/valuable.dart';

String email = 'Hexogon';
String password = 'Hexogon';

List<Menu> sidebarMenus = [
  // Menu(
  //   title: "Tổng quan".toUpperCase(),
  //   rive: RiveModel(
  //       src: "assets/RiveAssets/icons.riv",
  //       artboard: "HOME",
  //       stateMachineName: "HOME_interactivity"),
  // ),
  Menu(
    title: rooms[0].nameUI,
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "ROOM",
        stateMachineName: "ROOM_interactivity"),
  ),
  // Menu(
  //   title: rooms[1].nameUI,
  //   rive: RiveModel(
  //       src: "assets/RiveAssets/icons.riv",
  //       artboard: "ROOM",
  //       stateMachineName: "ROOM_interactivity"),
  // ),
  // Menu(
  //   title: rooms[2].nameUI,
  //   rive: RiveModel(
  //       src: "assets/RiveAssets/icons.riv",
  //       artboard: "ROOM",
  //       stateMachineName: "ROOM_interactivity"),
  // ),
  // Menu(
  //   title: rooms[3].nameUI,
  //   rive: RiveModel(
  //       src: "assets/RiveAssets/icons.riv",
  //       artboard: "ROOM",
  //       stateMachineName: "ROOM_interactivity"),
  // ),
  // Menu(
  //   title: rooms[4].nameUI,
  //   rive: RiveModel(
  //       src: "assets/RiveAssets/icons.riv",
  //       artboard: "ROOM",
  //       stateMachineName: "ROOM_interactivity"),
  // ),
  // Menu(
  //   title: rooms[5].nameUI,
  //   rive: RiveModel(
  //       src: "assets/RiveAssets/icons.riv",
  //       artboard: "ROOM",
  //       stateMachineName: "ROOM_interactivity"),
  // ),
];

AllRoom allRoom = AllRoom(
  canRun: StatefulValuable<bool>(false),
  current_preset: StatefulValuable<int>(10),
  current_colume: StatefulValuable<int>(1),
  power_all_projectors: StatefulValuable<bool>(false),
  power_all_servers: StatefulValuable<bool>(false),
  is_switch_colume: StatefulValuable<bool>(false),
  shutter_all_projectors: StatefulValuable<bool>(false),
  volume_all: StatefulValuable<double>(1),
  current_transport: StatefulValuable<double>(0),
  num_servers_connected: StatefulValuable<int>(0),
  num_projectors_connected: StatefulValuable<int>(0),
  num_servers: StatefulValuable<int>(0),
  num_sensors: StatefulValuable<int>(0),
  num_leds: StatefulValuable<int>(0),
  num_projectors: StatefulValuable<int>(0),
  allVolumeFB: [],
  volumeId: StatefulValuable<String>(''),
  volumeCollection: Firestore.instance.collection('volume'),
  presets: [
    Preset(
        name: '123',
        image: 'assets/Preset4.1.png',
        osc_message: 'column 1',
        transport: StatefulValuable<double>(0)),
    Preset(
        name: '231',
        image: 'assets/Preset4.2.png',
        osc_message: 'column 2',
        transport: StatefulValuable<double>(0)),
    Preset(
        name: '312',
        image: 'assets/Preset4.3.png',
        osc_message: 'column 3',
        transport: StatefulValuable<double>(0)),
  ],
);

List<Room> rooms = [
  Room(
    nameDatabase: 'volumeP3',
    nameUI:
     'VĂN MIẾU',
    map: 'assets/Map/P3.png',
    general: 'Khu vực nghệ thuật tự do',
    resolume: true,
    power_room_projectors: StatefulValuable<bool>(false),
    shutter_room_projectors: StatefulValuable<bool>(false),
    isSelectedPlay: StatefulValuable<bool>(false),
    isSelectedStop: StatefulValuable<bool>(false),
    current_preset: StatefulValuable<int>(10),
    roomVolumeFB: [],
    roomVolumeId: StatefulValuable<String>(''),
    roomVolumeCollection: Firestore.instance.collection('volume'),
    sensors: [],
    leds: [],
    presets: [],
    projectors: [
      Projector(
        ip: '192.168.1.101',
        name: 'Máy chiếu 01',
        port: 3002,
        position: Offset(0.2295, 0.15),
        UsernameAndPassword: 'admin',
        type: 'PJLink',
        power_status_button: StatefulValuable<bool>(false),
        shutter_status_button: StatefulValuable<bool>(false),
        power_status: StatefulValuable<bool>(false),
        shutter_status: StatefulValuable<bool>(false),
        connected: StatefulValuable<bool>(false),
        isOnHover: StatefulValuable<bool>(false),
        lamp_hours: StatefulValuable<double>(0),
        status: StatefulValuable<int>(0),
        color_state: StatefulValuable<bool>(false),
      ),
      Projector(
        ip: '192.168.1.102',
        name: 'Máy chiếu 02',
        port: 3002,
        position: Offset(0.2295, 0.15),
        UsernameAndPassword: 'admin',
        type: 'PJLink',
        power_status_button: StatefulValuable<bool>(false),
        shutter_status_button: StatefulValuable<bool>(false),
        power_status: StatefulValuable<bool>(false),
        shutter_status: StatefulValuable<bool>(false),
        connected: StatefulValuable<bool>(false),
        isOnHover: StatefulValuable<bool>(false),
        lamp_hours: StatefulValuable<double>(0),
        status: StatefulValuable<int>(0),
        color_state: StatefulValuable<bool>(false),
      ),
      Projector(
        ip: '192.168.1.103',
        name: 'Máy chiếu 03',
        port: 3002,
        position: Offset(0.2295, 0.15),
        UsernameAndPassword: 'admin',
        type: 'PJLink',
        power_status_button: StatefulValuable<bool>(false),
        shutter_status_button: StatefulValuable<bool>(false),
        power_status: StatefulValuable<bool>(false),
        shutter_status: StatefulValuable<bool>(false),
        connected: StatefulValuable<bool>(false),
        isOnHover: StatefulValuable<bool>(false),
        lamp_hours: StatefulValuable<double>(0),
        status: StatefulValuable<int>(0),
        color_state: StatefulValuable<bool>(false),
      ),
      Projector(
        ip: '192.168.1.104',
        name: 'Máy chiếu 04',
        port: 3002,
        position: Offset(0.2295, 0.15),
        UsernameAndPassword: 'admin',
        type: 'PJLink',
        power_status_button: StatefulValuable<bool>(false),
        shutter_status_button: StatefulValuable<bool>(false),
        power_status: StatefulValuable<bool>(false),
        shutter_status: StatefulValuable<bool>(false),
        connected: StatefulValuable<bool>(false),
        isOnHover: StatefulValuable<bool>(false),
        lamp_hours: StatefulValuable<double>(0),
        status: StatefulValuable<int>(0),
        color_state: StatefulValuable<bool>(false),
      ),
      Projector(
        ip: '192.168.1.105',
        name: 'Máy chiếu 05',
        port: 3002,
        position: Offset(0.2295, 0.15),
        UsernameAndPassword: 'admin',
        type: 'PJLink',
        power_status_button: StatefulValuable<bool>(false),
        shutter_status_button: StatefulValuable<bool>(false),
        power_status: StatefulValuable<bool>(false),
        shutter_status: StatefulValuable<bool>(false),
        connected: StatefulValuable<bool>(false),
        isOnHover: StatefulValuable<bool>(false),
        lamp_hours: StatefulValuable<double>(0),
        status: StatefulValuable<int>(0),
        color_state: StatefulValuable<bool>(false),
      ),
    ],
    servers: [],
  ),
];
