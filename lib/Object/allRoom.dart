import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Preset.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Sensor.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/Object/Test_Pattern.dart';
import 'package:valuable/valuable.dart';

class AllRoom {
    StatefulValuable<bool> power_all_projectors;
    StatefulValuable<bool> shutter_all_projectors;
    StatefulValuable<bool> power_all_servers;
    StatefulValuable<double> volume_all;
    StatefulValuable<int> current_test_pattern;
    StatefulValuable<int> current_preset;
    StatefulValuable<bool> electronic_mode;
    StatefulValuable<bool> ASU_mode;
    StatefulValuable<bool> OSD_mode;
    StatefulValuable<bool> whiteOrGreen;
    StatefulValuable<bool> A1;
    StatefulValuable<bool> A2;
    StatefulValuable<bool> A3;
    StatefulValuable<bool> B1;
    StatefulValuable<bool> B2;
    StatefulValuable<bool> B3;
    StatefulValuable<int> lamp_mode;
    StatefulValuable<int> num_servers_connected;
    StatefulValuable<int> num_projectors_connected;
    StatefulValuable<int> num_servers;
    StatefulValuable<int> num_sensors;
    StatefulValuable<int> num_projectors;
    List<Preset> presets; // : 1,2,3
    List<TestPattern> test_patterns; // : 1,2,3
    // List<Projector> projectors;
    // List<Server> servers;

    // Constructor
    AllRoom({
        required this.power_all_projectors,
        required this.shutter_all_projectors,
        required this.power_all_servers,
        required this.volume_all,
        required this.current_test_pattern,
        required this.current_preset,
        required this.ASU_mode,
        required this.OSD_mode,
        required this.A1,
        required this.A2,
        required this.A3,
        required this.B1,
        required this.B2,
        required this.B3,
        required this.whiteOrGreen,
        required this.electronic_mode,
        required this.presets,
        required this.test_patterns,
        required this.lamp_mode,
        required this.num_servers_connected,
        required this.num_projectors_connected,
        required this.num_servers,
        required this.num_sensors,
        required this.num_projectors,
    });
}
