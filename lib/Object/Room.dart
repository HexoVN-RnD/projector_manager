import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Led.dart';
import 'package:responsive_dashboard/Object/Preset.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Sensor.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:valuable/valuable.dart';

class Room {
    StatefulValuable<bool> power_room_projectors;
    StatefulValuable<bool> shutter_room_projectors;
    StatefulValuable<bool> isSelectedPlay;
    StatefulValuable<bool> isSelectedStop;
    String name;
    String map;
    String general;
    bool resolume;
    List<Sensor> sensors;
    List<Led> leds;
    StatefulValuable<int> current_preset;
    List<Preset> presets; // : 1,2,3
    List<Projector> projectors;
    List<Server> servers;

    // Constructor
    Room({
        required this.name,
        required this.power_room_projectors,
        required this.shutter_room_projectors,
        required this.isSelectedPlay,
        required this.isSelectedStop,
        required this.map,
        required this.general,
        required this.resolume,
        required this.sensors,
        required this.leds,
        required this.current_preset,
        required this.presets,
        required this.projectors,
        required this.servers,
    });
}
