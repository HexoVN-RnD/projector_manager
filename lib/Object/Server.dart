import 'package:flutter/material.dart';
import 'package:valuable/valuable.dart';

class Server {
    String ip;
    String name;
    int port;
    String username;
    String password;
    StatefulValuable<bool> power_status;
    StatefulValuable<bool> mute_audio;
    StatefulValuable<bool> connected;

    // Constructor
    Server({
        @required this.ip,
        @required this.name,
        @required this.port,
        this.username,
        this.password,
        this.power_status,
        this.mute_audio,
        this.connected,
    });
}
