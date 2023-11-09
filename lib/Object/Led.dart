import 'package:flutter/material.dart';
import 'package:valuable/valuable.dart';

class Led {
    String ip;
    String name;
    int port;
    bool connected;
    double position_x;
    double position_y;


    // Constructor
    Led({
        required this.ip,
        required this.name,
        required this.position_x,
        required this.position_y,
        required this.port,
        required this.connected,
    });
}
