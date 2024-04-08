import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_dashboard/Method/Osc_void.dart';
import 'package:responsive_dashboard/Method/audio_void.dart';
import 'package:responsive_dashboard/Method/excel.dart';
import 'package:responsive_dashboard/Method/projector_command.dart';
import 'package:responsive_dashboard/Method/udp_void.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

class AllServerStatus extends StatefulWidget {
  Room room;

  AllServerStatus({
    required this.room,
  });

  @override
  _AllServerStatusState createState() => _AllServerStatusState();
}

// class _MainPageState extends State<MainPage> {
//   bool value = true;

class _AllServerStatusState extends State<AllServerStatus> {
  void ChangeVolume(Room room, Server server, double index) {
    // writeCellValue(index.toStringAsFixed(2), server.id, 1);
    if (room.resolume) {
      SendAudioOSC(room, index);
    } else {
      SendUDPAudioMessage(server, index);
    }
    server.volume.setValue(index);
  }

  @override
  Widget build(BuildContext context) {
    Room room = widget.room;
    return room.servers.length>1 ? Column(
        children: List.generate(
      room.servers.length,
      (index) => Container(
        alignment: Alignment.center,
        width: 140,
        height: 45,
        margin: EdgeInsets.fromLTRB(20 , 10, 20, 0),
        decoration: BoxDecoration(
            color: room.servers[index].connected.getValue()
                ? AppColors.green
                : AppColors.red,
            borderRadius: BorderRadius.circular(15)),
        child: PrimaryText(
          text: room.servers[index].shotname,
          size: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    )):
    Container(
      alignment: Alignment.center,
      width: 140,
      height: 100,
      margin: EdgeInsets.fromLTRB(20 , 10, 20, 0),
      decoration: BoxDecoration(
          color: room.servers[0].connected.getValue()
              ? AppColors.green
              : AppColors.red,
          borderRadius: BorderRadius.circular(20)),
      child: PrimaryText(
        text: room.servers[0].shotname,
        size: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
