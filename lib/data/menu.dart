import 'package:flutter/material.dart';

import '../Object/rive_model.dart';
import 'data.dart';

class Menu {
  final String title;
  final RiveModel rive;

  Menu({required this.title, required this.rive});
}

List<Menu> sidebarMenus = [
  Menu(
    title: "Tổng quan".toUpperCase(),
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "HOME",
        stateMachineName: "HOME_interactivity"),
  ),
  Menu(
    title: rooms[0].name,
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "ROOM",
        stateMachineName: "ROOM_interactivity"),
  ),
  Menu(
    title: rooms[1].name,
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "ROOM",
        stateMachineName: "ROOM_interactivity"),
  ),
  Menu(
    title: rooms[2].name,
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "ROOM",
        stateMachineName: "ROOM_interactivity"),
  ),
  Menu(
    title: rooms[3].name,
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "ROOM",
        stateMachineName: "ROOM_interactivity"),
  ),
];
