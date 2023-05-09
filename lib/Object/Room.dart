import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Sensor.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:valuable/valuable.dart';

class Room {
    String name;
    String general;
    List<Sensor> sensors;
    StatefulValuable<bool> resolume;
    StatefulValuable<int> preset; // : 1,2,3
    List<Projector> projectors;
    List<Server> servers;

    // Constructor
    Room({
        @required this.name,
        @required this.general,
        @required this.sensors,
        @required this.resolume,
        @required this.preset,
        @required this.projectors,
        @required this.servers,
    });
}
