import 'package:flutter/material.dart';
import 'package:valuable/valuable.dart';

class Projector {
    String ip;
    String name;
    int port;
    String type;
    String UsernameAndPassword;
    StatefulValuable<bool> power_status_button;
    StatefulValuable<bool> shutter_status_button;
    StatefulValuable<bool> connected;
    StatefulValuable<bool> power_status;
    StatefulValuable<bool> shutter_status;
    StatefulValuable<double> lamp_hours;
    Offset position;
    StatefulValuable<bool> color_state;
    StatefulValuable<bool> isOnHover;
    StatefulValuable<String> log = StatefulValuable<String>('0 error 0 warning');


    // Constructor
    Projector({
        required this.ip,
        required this.name,
        required this.port,
        required this.type,
        required this.UsernameAndPassword,
        required this.power_status_button,
        required this.shutter_status_button,
        required this.power_status,
        required this.shutter_status,
        required this.lamp_hours,
        required this.connected,
        required this.position,
        // this.lamp_hours = StatefulValuable<double>(0),
        required this.color_state,
        required this.isOnHover,
    });
}
