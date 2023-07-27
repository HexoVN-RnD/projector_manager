import 'package:flutter/material.dart';
import 'package:valuable/valuable.dart';

class TestPattern {
  String name;
  String image;
  String osc_message;
  StatefulValuable<double> transport;
  // Constructor
  TestPattern({
    required this.name,
    required this.image,
    required this.osc_message,
    required this.transport,
  });
}
