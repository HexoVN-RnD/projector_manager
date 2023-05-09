import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:valuable/valuable.dart';

class Sensor {
    String ip;
    String name;
    int port;
    StatefulValuable<bool> connected;

    // Constructor
    Sensor({
        @required this.ip,
        @required this.name,
        @required this.port,
        this.connected,
    });
}
