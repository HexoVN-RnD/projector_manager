import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:valuable/valuable.dart';

class Preset {
    String name;
    String image;
    String osc_message;
    StatefulValuable<double> transport;
    // Constructor
    Preset({
        @required this.name,
        @required this.image,
        @required this.osc_message,
        @required this.transport,
    });
}
