import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class Projector {
  String name;
  bool powerOn;

  Projector({this.name, this.powerOn});
}

class ProjectorListPage extends StatefulWidget {
  @override
  _ProjectorListPageState createState() => _ProjectorListPageState();
}

class _ProjectorListPageState extends State<ProjectorListPage> {
  List<Projector> list_projector = [
    Projector(name: 'Projector 1', powerOn: false),
    Projector(name: 'Projector 2', powerOn: true),
    Projector(name: 'Projector 3', powerOn: false),
    Projector(name: 'Projector 4', powerOn: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projector List'),
      ),
      body: ListView.builder(
        itemCount: list_projector.length,
        itemBuilder: (context, index) {
          return InfoProjector(projector: list_projector[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          refreshList();
        },
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }

  void refreshList() {
    setState(() {
      // Update list_projector here
      list_projector = [
        Projector(name: 'Projector 1', powerOn: true),
        Projector(name: 'Projector 2', powerOn: false),
        Projector(name: 'Projector 3', powerOn: true),
        Projector(name: 'Projector 4', powerOn: false),
      ];
    });
  }
}

class InfoProjector extends StatelessWidget {
  final Projector projector;

  InfoProjector({this.projector});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(projector.name),
      subtitle: Text('Power: ${projector.powerOn ? 'On' : 'Off'}'),
    );
  }
}
