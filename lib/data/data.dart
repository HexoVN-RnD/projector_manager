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
  Menu(
    title: "Tổng quan".toUpperCase(),
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "HOME",
        stateMachineName: "HOME_interactivity"),
  ),
  Menu(
    title: rooms[0].nameUI,
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "ROOM",
        stateMachineName: "ROOM_interactivity"),
  ),
  Menu(
    title: rooms[1].nameUI,
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "ROOM",
        stateMachineName: "ROOM_interactivity"),
  ),
  Menu(
    title: rooms[2].nameUI,
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "ROOM",
        stateMachineName: "ROOM_interactivity"),
  ),
  Menu(
    title: rooms[3].nameUI,
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "ROOM",
        stateMachineName: "ROOM_interactivity"),
  ),
  Menu(
    title: rooms[4].nameUI,
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "ROOM",
        stateMachineName: "ROOM_interactivity"),
  ),
  Menu(
    title: rooms[5].nameUI,
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "ROOM",
        stateMachineName: "ROOM_interactivity"),
  ),
];

AllRoom allRoom = AllRoom(
  canRun: false,
  current_preset: 10,
  current_colume: 1,
  power_all_projectors: false,
  power_all_servers: false,
  is_switch_colume: false,
  shutter_all_projectors: false,
  volume_all: 1,
  current_transport: 0,
  num_servers_connected: 0,
  num_projectors_connected: 0,
  num_servers: 0,
  num_sensors: 0,
  num_leds: 0,
  num_projectors: 0,
  allVolumeFB: [],
  volumeId: '',
  // volumeCollection: Firestore.instance.collection('volume'),
  presets: [
    Preset(
        name: '123',
        image: 'assets/Preset4.1.png',
        osc_message: 'column 1',
        transport: 0),
    Preset(
        name: '231',
        image: 'assets/Preset4.2.png',
        osc_message: 'column 2',
        transport: 0),
    Preset(
        name: '312',
        image: 'assets/Preset4.3.png',
        osc_message: 'column 3',
        transport: 0),
  ],
);

List<Room> rooms = [
  Room(
    nameDatabase: 'volumeP1',
    nameUI:
     'SOÁT VÉ',
    map: 'assets/Map/SoatVe.png',
    general: 'Khu vực soát vé',
    resolume: true,
    power_room_projectors: false,
    shutter_room_projectors: false,
    isSelectedPlay: false,
    isSelectedStop: false,
    sensors: [],
    leds: [],
    roomVolumeFB: [],
    roomVolumeId: '',
    // roomVolumeCollection: Firestore.instance.collection('volume'),
    current_preset: 10,
    presets: [],
    projectors: [],
    servers: [
      Server(
        shotname: 'SV Soát Vé',
        id: 11,
        ip: '192.168.1.246',
        name: 'Server soát vé',
        preset_port: 7000,
        power_port: 1234,
         position_x: 0.0,
        position_y: 0.0,
        mac_address: '00:4e:01:b9:42:a0',
        password: 'admin',
        power_status: false,
        volume: 1,
        connected: false,
        isOnHover: false,
      ),
    ],
  ),
  Room(
    nameDatabase: 'volumeP2',
    nameUI:
     'PHÒNG 2',
    map: 'assets/Map/P2.png',
    general: 'Sảnh đón tiếp',
    resolume: false,
    sensors: [],
    leds: [],
    roomVolumeFB: [],
    roomVolumeId: '',
    // roomVolumeCollection: Firestore.instance.collection('volume'),
    power_room_projectors: false,
    shutter_room_projectors: false,
    isSelectedPlay: false,
    isSelectedStop: false,
    current_preset: 10,
    presets: [
      Preset(
          name: 'Đâm Chồi Nảy Lộc',
          image: 'assets/Preset2.png',
          osc_message: 'column 1',
          transport: 0),
    ],
    projectors: [],
    servers: [
      Server(
        shotname: '',
        id: 1,
        ip: '192.168.1.51',
        name: 'Brightsign 01',
        preset_port: 5000,
        power_port: 1234,
         position_x: 0.0,
        position_y: 0.0,
        mac_address: 'd4:5d:64:d0:54:c7',
        password: 'admin',
        power_status: false,
        volume: 1,
        connected: false,
        isOnHover: false,
      ),
      Server(
        shotname: '',
        id: 2,
        ip: '192.168.1.52',
        name: 'Brightsign 02',
        preset_port: 5000,
        power_port: 1234,
         position_x: 0.0,
        position_y: 0.0,
        mac_address: 'd4:5d:64:d0:54:c7',
        password: 'admin',
        power_status: false,
        volume: 1,
        connected: false,
        isOnHover: false,
      ),
      Server(
        shotname: '',
        id: 3,
        ip: '192.168.1.53',
        name: 'Brightsign 03',
        preset_port: 5000,
        power_port: 1234,
         position_x: 0.0,
        position_y: 0.0,
        mac_address: 'd4:5d:64:d0:54:c7',
        password: 'admin',
        power_status: false,
        volume: 1,
        connected: false,
        isOnHover: false,
      ),
      Server(
        shotname: '',
        id: 4,
        ip: '192.168.1.54',
        name: 'Brightsign 04',
        preset_port: 5000,
        power_port: 1234,
         position_x: 0.0,
        position_y: 0.0,
        mac_address: 'd4:5d:64:d0:54:c7',
        password: 'admin',
        power_status: false,
        volume: 1,
        connected: false,
        isOnHover: false,
      ),
      Server(
        shotname: '',
        id: 5,
        ip: '192.168.1.55',
        name: 'Brightsign 05',
        preset_port: 5000,
        power_port: 1234,
         position_x: 0.0,
        position_y: 0.0,
        mac_address: 'd4:5d:64:d0:54:c7',
        password: 'admin',
        power_status: false,
        volume: 1,
        connected: false,
        isOnHover: false,
      ),
      Server(
        shotname: '',
        id: 6,
        ip: '192.168.1.56',
        name: 'Brightsign 06',
        preset_port: 5000,
        power_port: 1234,
         position_x: 0.0,
        position_y: 0.0,
        mac_address: 'd4:5d:64:d0:54:c7',
        password: 'admin',
        power_status: false,
        volume: 1,
        connected: false,
        isOnHover: false,
      ),
      Server(
        shotname: '',
        id: 7,
        ip: '192.168.1.57',
        name: 'Brightsign 07',
        preset_port: 5000,
        power_port: 1234,
         position_x: 0.0,
        position_y: 0.0,
        mac_address: 'd4:5d:64:d0:54:c7',
        password: 'admin',
        power_status: false,
        volume: 1,
        connected: false,
        isOnHover: false,
      ),
      Server(
        shotname: '',
        id: 8,
        ip: '192.168.1.58',
        name: 'Brightsign 08',
        preset_port: 5000,
        power_port: 1234,
         position_x: 0.0,
        position_y: 0.0,
        mac_address: 'd4:5d:64:d0:54:c7',
        password: 'admin',
        power_status: false,
        volume: 1,
        connected: false,
        isOnHover: false,
      ),
    ],
  ),
  Room(
    nameDatabase: 'volumeP3',
    nameUI:
     'PHÒNG 3',
    map: 'assets/Map/P3.png',
    general: 'Khu vực nghệ thuật tự do',
    resolume: true,
    power_room_projectors: false,
    shutter_room_projectors: false,
    isSelectedPlay: false,
    isSelectedStop: false,
    current_preset: 10,
    roomVolumeFB: [],
    roomVolumeId: '',
    // roomVolumeCollection: Firestore.instance.collection('volume'),
    sensors: [],
    leds: [
      Led(
          ip: '192.168.1.247',
          name: 'Màn led 01',
           position_x: 0.0,
        position_y: 0.0,
          port: 10940,
          connected: false),
      Led(
          ip: '192.168.1.247',
          name: 'Màn led 02',
           position_x: 0.0,
        position_y: 0.0,
          port: 10940,
          connected: false)
    ],
    presets: [
      Preset(
          name: 'Hồng Sắc Long',
          image: 'assets/Preset3.png',
          osc_message: 'column 1',
          transport: 0),
    ],
    projectors: [
      Projector(
        ip: '192.168.1.140',
        name: 'Máy chiếu tường',
        port: 3002,
         position_x: 0.0,
        position_y: 0.0,
        UsernameAndPassword: 'admin',
        type: 'PJLink',
        power_status_button: false,
        shutter_status_button: false,
        power_status: false,
        shutter_status: false,
        connected: false,
        isOnHover: false,
        lamp_hours: 0,
        status: 0,
        color_state: false,
      ),
      Projector(
        ip: '192.168.1.141',
        name: 'Máy chiếu tượng',
        port: 3002,
         position_x: 0.0,
        position_y: 0.0,
        UsernameAndPassword: 'admin',
        type: 'PJLink',
        power_status_button: false,
        shutter_status_button: false,
        power_status: false,
        shutter_status: false,
        connected: false,
        isOnHover: false,
        lamp_hours: 0,
        status: 0,
        color_state: false,
      ),
    ],
    servers: [
      Server(
        shotname: 'MAPPING P3',
        id: 9,
        ip: '192.168.1.247',
        name: 'Server mapping phòng 3',
        preset_port: 7000,
        power_port: 1234,
         position_x: 0.0,
        position_y: 0.0,
        mac_address: '5c:60:ba:3e:ce:1a',
        password: 'admin',
        power_status: false,
        volume: 1,
        connected: false,
        isOnHover: false,
      ),
    ],
  ),
  Room(
    nameDatabase: 'volumeP4',
    nameUI:
     'PHÒNG 4',
    map: 'assets/Map/P4.png',
    general: 'Phòng trải nghiệm không gian đa chiều',
    resolume: true,
    power_room_projectors: false,
    shutter_room_projectors: false,
    isSelectedPlay: false,
    isSelectedStop: false,
    current_preset: 10,
    sensors: [],
    leds: [],
    roomVolumeFB: [],
    roomVolumeId: '',
    // roomVolumeCollection: Firestore.instance.collection('volume'),
    presets: [
      Preset(
          name: 'Mọi Miền Tiềm Thức',
          image: 'assets/Preset4.1.png',
          osc_message: 'column 1',
          transport: 0),
      Preset(
          name: 'Như Một Dòng Chảy',
          image: 'assets/Preset4.2.png',
          osc_message: 'column 2',
          transport: 0),
      Preset(
          name: 'Một Trăm',
          image: 'assets/Preset4.3.png',
          osc_message: 'column 3',
          transport: 0),
      // Preset(
      //     name: 'Nội dung 4',
      //     image: 'assets/watching-a-movie_black.png',
      //     osc_message: 'column 4',
      //     transport: 0),
    ],
    projectors: [
      Projector(
        ip: '192.168.1.101',
        name: 'Máy chiếu sàn 01',
        port: 3002,
         position_x: 0.0,
        position_y: 0.0,
        UsernameAndPassword: 'admin',
        type: 'PJLink',
        power_status_button: false,
        shutter_status_button: false,
        power_status: false,
        shutter_status: false,
        connected: false,
        isOnHover: false,
        lamp_hours: 0,
        status: 0,
        color_state: false,
      ),
      Projector(
        ip: '192.168.1.102',
        name: 'Máy chiếu sàn 02',
        port: 3002,
         position_x: 0.0,
        position_y: 0.0,
        UsernameAndPassword: 'admin',
        type: 'PJLink',
        power_status_button: false,
        shutter_status_button: false,
        power_status: false,
        shutter_status: false,
        connected: false,
        isOnHover: false,
        lamp_hours: 0,
        status: 0,
        color_state: false,
      ),
      Projector(
        ip: '192.168.1.103',
        name: 'Máy chiếu sàn 03',
        port: 3002,
         position_x: 0.0,
        position_y: 0.0,
        UsernameAndPassword: 'admin',
        type: 'PJLink',
        power_status_button: false,
        shutter_status_button: false,
        power_status: false,
        shutter_status: false,
        connected: false,
        isOnHover: false,
        lamp_hours: 0,
        status: 0,
        color_state: false,
      ),
      Projector(
        ip: '192.168.1.104',
        name: 'Máy chiếu sàn 04',
        port: 3002,
         position_x: 0.0,
        position_y: 0.0,
        UsernameAndPassword: 'admin',
        type: 'PJLink',
        power_status_button: false,
        shutter_status_button: false,
        power_status: false,
        shutter_status: false,
        connected: false,
        isOnHover: false,
        lamp_hours: 0,
        status: 0,
        color_state: false,
      ),
      Projector(
        ip: '192.168.1.105',
        name: 'Máy chiếu sàn 05',
        port: 3002,
         position_x: 0.0,
        position_y: 0.0,
        UsernameAndPassword: 'admin',
        type: 'PJLink',
        power_status_button: false,
        shutter_status_button: false,
        power_status: false,
        shutter_status: false,
        connected: false,
        isOnHover: false,
        lamp_hours: 0,
        status: 0,
        color_state: false,
      ),
    ],
    servers: [
      Server(
        shotname: 'MAPPING SÀN P4',
        id: 9,
        ip: '192.168.1.242',
        name: 'Server mapping sàn phòng 4',
        preset_port: 7000,
        power_port: 1234,
         position_x: 0.0,
        position_y: 0.0,
        mac_address: 'e0:73:e7:0b:21:af',
        password: 'admin',
        power_status: false,
        volume: 1,
        connected: false,
        isOnHover: false,
      ),
      Server(
        shotname: 'MAPPING TƯỜNG P4',
        id: 10,
        ip: '192.168.1.243',
        name: 'Server mapping tường phòng 4',
        preset_port: 7000,
        power_port: 1234,
         position_x: 0.0,
        position_y: 0.0,
        mac_address: 'c4:00:ad:9e:91:92',
        password: 'admin',
        power_status: false,
        volume: 1,
        connected: false,
        isOnHover: false,
      ),
    ],
  ),
  Room(
    nameDatabase: 'volumeP5',
    nameUI:
     'PHÒNG 5',
    map: 'assets/Map/P5.png',
    general: 'Khu vực tương tác',
    resolume: true,
    current_preset: 10,
    power_room_projectors: false,
    shutter_room_projectors: false,
    isSelectedPlay: false,
    isSelectedStop: false,
    leds: [],
    roomVolumeFB: [],
    roomVolumeId: '',
    // roomVolumeCollection: Firestore.instance.collection('volume'),
    sensors: [
      Sensor(
          ip: '192.168.1.11',
          name: 'Cảm biến 01',
           position_x: 0.0,
        position_y: 0.0,
          port: 10940,
          connected: false),
      Sensor(
          ip: '192.168.1.12',
          name: 'Cảm biến 02',
           position_x: 0.0,
        position_y: 0.0,
          port: 10940,
          connected: false),
      Sensor(
          ip: '192.168.1.13',
          name: 'Cảm biến 03',
           position_x: 0.0,
        position_y: 0.0,
          port: 10940,
          connected: false),
    ],
    presets: [
      Preset(
          name: 'Phản Chiếu',
          image: 'assets/Preset5.png',
          osc_message: 'column 1',
          transport: 0),
    ],
    projectors: [
      Projector(
        ip: '192.168.1.130',
        name: 'Máy chiếu sàn 01',
        port: 3002,
         position_x: 0.0,
        position_y: 0.0,
        UsernameAndPassword: 'admin',
        type: 'PJLink',
        power_status_button: false,
        shutter_status_button: false,
        power_status: false,
        shutter_status: false,
        connected: false,
        isOnHover: false,
        lamp_hours: 0,
        status: 0,
        color_state: false,
      ),
      Projector(
        ip: '192.168.1.131',
        name: 'Máy chiếu sàn 02',
        port: 3002,
         position_x: 0.0,
        position_y: 0.0,
        UsernameAndPassword: 'admin',
        type: 'PJLink',
        power_status_button: false,
        shutter_status_button: false,
        power_status: false,
        shutter_status: false,
        connected: false,
        isOnHover: false,
        lamp_hours: 0,
        status: 0,
        color_state: false,
      ),
      Projector(
        ip: '192.168.1.132',
        name: 'Máy chiếu sàn 03',
        port: 3002,
         position_x: 0.0,
        position_y: 0.0,
        UsernameAndPassword: 'admin',
        type: 'PJLink',
        power_status_button: false,
        shutter_status_button: false,
        power_status: false,
        shutter_status: false,
        connected: false,
        isOnHover: false,
        lamp_hours: 0,
        status: 0,
        color_state: false,
      ),
      Projector(
        ip: '192.168.1.133',
        name: 'Máy chiếu sàn 04',
        port: 3002,
         position_x: 0.0,
        position_y: 0.0,
        UsernameAndPassword: 'admin',
        type: 'PJLink',
        power_status_button: false,
        shutter_status_button: false,
        power_status: false,
        shutter_status: false,
        connected: false,
        isOnHover: false,
        lamp_hours: 0,
        status: 0,
        color_state: false,
      ),
    ],
    servers: [
      Server(
        shotname: 'TƯƠNG TÁC P5',
        id: 11,
        ip: '192.168.1.244',
        name: 'Server tương tác phòng 5',
        preset_port: 7000,
        power_port: 1234,
         position_x: 0.0,
        position_y: 0.0,
        mac_address: 'e0:73:e7:0D:fb:fa',
        password: 'admin',
        power_status: false,
        volume: 1,
        connected: false,
        isOnHover: false,
      ),
      Server(
        shotname: 'MAPPING P5',
        id: 12,
        ip: '192.168.1.245',
        name: 'Server mapping phòng 5',
        preset_port: 7000,
        power_port: 1234,
         position_x: 0.0,
        position_y: 0.0,
        mac_address: 'e0:73:e7:0b:6a:8a',
        password: 'admin',
        power_status: false,
        volume: 1,
        connected: false,
        isOnHover: false,
      ),
    ],
  ),
  Room(
    nameDatabase: 'volumeP6',
    nameUI:
     'PHÒNG 6',
    map: 'assets/Map/P6.png',
    general: 'Khu vực hội thảo event',
    resolume: false,
    power_room_projectors: false,
    shutter_room_projectors: false,
    isSelectedPlay: false,
    isSelectedStop: false,
    sensors: [],
    leds: [],
    roomVolumeFB: [],
    roomVolumeId: '',
    // roomVolumeCollection: Firestore.instance.collection('volume'),
    current_preset: 10,
    presets: [
      Preset(
          name: 'Hạnh Phúc Sinh Sôi ',
          image: 'assets/Preset6.1.png',
          osc_message: 'column 1',
          transport: 0),
      Preset(
          name: 'Ấm Thực Trừu Tượng',
          image: 'assets/Preset6.2.png',
          osc_message: 'column 2',
          transport: 0),
    ],
    projectors: [
      Projector(
        ip: '192.168.1.136',
        name: 'Máy chiếu 01',
        port: 3002,
         position_x: 0.0,
        position_y: 0.0,
        UsernameAndPassword: 'admin',
        type: 'PJLink',
        power_status_button: false,
        shutter_status_button: false,
        power_status: false,
        shutter_status: false,
        connected: false,
        isOnHover: false,
        lamp_hours: 0,
        status: 0,
        color_state: false,
      ),
      Projector(
        ip: '192.168.1.137',
        name: 'Máy chiếu 02',
        port: 3002,
         position_x: 0.0,
        position_y: 0.0,
        UsernameAndPassword: 'admin',
        type: 'PJLink',
        power_status_button: false,
        shutter_status_button: false,
        power_status: false,
        shutter_status: false,
        connected: false,
        isOnHover: false,
        lamp_hours: 0,
        status: 0,
        color_state: false,
      ),
      Projector(
        ip: '192.168.1.138',
        name: 'Máy chiếu 03',
        port: 3002,
         position_x: 0.0,
        position_y: 0.0,
        UsernameAndPassword: 'admin',
        type: 'PJLink',
        power_status_button: false,
        shutter_status_button: false,
        power_status: false,
        shutter_status: false,
        connected: false,
        isOnHover: false,
        lamp_hours: 0,
        status: 0,
        color_state: false,
      ),
      Projector(
        ip: '192.168.1.139',
        name: 'Máy chiếu 04',
        port: 3002,
         position_x: 0.0,
        position_y: 0.0,
        UsernameAndPassword: 'admin',
        type: 'PJLink',
        power_status_button: false,
        shutter_status_button: false,
        power_status: false,
        shutter_status: false,
        connected: false,
        isOnHover: false,
        lamp_hours: 0,
        status: 0,
        color_state: false,
      ),
    ],
    servers: [
      Server(
        shotname: '',
        id: 13,
        ip: '192.168.1.59',
        name: 'Brightsign 09',
        preset_port: 5000,
        power_port: 1234,
         position_x: 0.0,
        position_y: 0.0,
        mac_address: 'd4:5d:64:d0:54:c7',
        password: 'admin',
        power_status: false,
        volume: 1,
        connected: false,
        isOnHover: false,
      ),
      Server(
        shotname: '',
        id: 14,
        ip: '192.168.1.60',
        name: 'Brightsign 10',
        preset_port: 5000,
        power_port: 1234,
         position_x: 0.0,
        position_y: 0.0,
        mac_address: 'd4:5d:64:d0:54:c7',
        password: 'admin',
        power_status: false,
        volume: 1,
        connected: false,
        isOnHover: false,
      ),
    ],
  ),
];
