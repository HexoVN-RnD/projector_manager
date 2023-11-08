import 'package:flutter/material.dart';
import 'package:valuable/valuable.dart';

class Projector {
    String ip;
    String name;
    int port;
    String UsernameAndPassword;
    String type;
    bool power_status_button;
    bool shutter_status_button;
    bool connected;
    bool power_status;
    bool shutter_status;
    double lamp_hours;
    int status;
    Offset position;
    bool color_state;
    bool isOnHover;


    // Constructor
    Projector({
        required this.ip,
        required this.name,
        required this.port,
        required this.UsernameAndPassword,
        required this.type,
        required this.power_status_button,
        required this.shutter_status_button,
        required this.power_status,
        required this.shutter_status,
        required this.lamp_hours,
        required this.status,
        required this.connected,
        required this.position,
        // this.lamp_hours = StatefulValuable<double>(0),
        required this.color_state,
        required this.isOnHover,
    });
}
