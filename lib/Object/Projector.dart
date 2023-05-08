import 'package:flutter/material.dart';
import 'package:valuable/valuable.dart';

class Projector {
    String ip;
    String name;
    int port;
    String username;
    String password;
    StatefulValuable<bool> power_status;
    StatefulValuable<bool> shutter_status;
    StatefulValuable<bool> connected;
    // lamp hours
    // position
    // color disconnect/off/on

    // Constructor
    Projector({
        @required this.ip,
        @required this.name,
        @required this.port,
        this.username,
        this.password,
        this.power_status,
        this.shutter_status,
        this.connected,
    });
}
