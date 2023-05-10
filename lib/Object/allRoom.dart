import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Preset.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Sensor.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:valuable/valuable.dart';

class AllRoom {
    StatefulValuable<bool> power_all_projectors;
    StatefulValuable<bool> shutter_all_projectors;
    StatefulValuable<bool> power_all_servers;
    StatefulValuable<double> volume_all;
    StatefulValuable<int> current_preset;
    StatefulValuable<int> num_servers_connected;
    StatefulValuable<int> num_projectors_connected;
    StatefulValuable<int> num_servers;
    StatefulValuable<int> num_projectors;
    List<Preset> presets; // : 1,2,3
    // List<Projector> projectors;
    // List<Server> servers;

    // Constructor
    AllRoom({
        @required this.power_all_projectors,
        @required this.shutter_all_projectors,
        @required this.power_all_servers,
        @required this.volume_all,
        @required this.current_preset,
        @required this.presets,
        this.num_servers_connected,
        this.num_projectors_connected,
        this.num_servers,
        this.num_projectors,
    });
}
