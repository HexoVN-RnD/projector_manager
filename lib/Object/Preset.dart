import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:valuable/valuable.dart';

class Preset {
    String name;
    StatefulValuable<int> current_preset;
    String image;
    String osc_message;
    // Constructor
    Preset({
        @required this.name,
        @required this.current_preset,
        @required this.image,
        @required this.osc_message,
    });
}
