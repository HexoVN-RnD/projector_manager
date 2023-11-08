import 'package:flutter/material.dart';
import 'package:valuable/valuable.dart';

class Led {
    String ip;
    String name;
    int port;
    bool connected;
    Offset position;


    // Constructor
    Led({
        required this.ip,
        required this.name,
        required this.position,
        required this.port,
        required this.connected,
    });
}
