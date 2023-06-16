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
    StatefulValuable<int> current_test_pattern = StatefulValuable<int>(0);
    StatefulValuable<int> lamp_mode = StatefulValuable<int>(0);
    StatefulValuable<bool> electronic_mode = StatefulValuable<bool>(false);
    StatefulValuable<bool> ASU_mode = StatefulValuable<bool>(false);
    StatefulValuable<bool> OSD_mode = StatefulValuable<bool>(false);
    StatefulValuable<bool> whiteOrGreen = StatefulValuable<bool>(false);
    StatefulValuable<bool> A1 = StatefulValuable<bool>(true);
    StatefulValuable<bool> A2 = StatefulValuable<bool>(true);
    StatefulValuable<bool> A3 = StatefulValuable<bool>(true);
    StatefulValuable<bool> B1 = StatefulValuable<bool>(true);
    StatefulValuable<bool> B2 = StatefulValuable<bool>(true);
    StatefulValuable<bool> B3 = StatefulValuable<bool>(true);
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
