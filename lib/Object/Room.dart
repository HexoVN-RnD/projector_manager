import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:valuable/valuable.dart';

class Room {
    String name;
    String general;
    List<Projector> projectors;
    List<Server> servers;

    // Constructor
    Room({
        @required this.name,
        @required this.general,
        @required this.projectors,
        @required this.servers,
    });
}
