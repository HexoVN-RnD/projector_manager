import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Preset.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Sensor.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:valuable/valuable.dart';

class Room {
    String name;
    String general;
    bool resolume;
    List<Sensor> sensors;
    StatefulValuable<int> current_preset;
    List<Preset> presets; // : 1,2,3
    List<Projector> projectors;
    List<Server> servers;

    // Constructor
    Room({
        required this.name,
        required this.general,
        required this.resolume,
        required this.sensors,
        required this.current_preset,
        required this.presets,
        required this.projectors,
        required this.servers,
    });
}
