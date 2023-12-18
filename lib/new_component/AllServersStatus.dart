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
import 'package:responsive_dashboard/Object/RoomData.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

class AllServerStatus extends StatefulWidget {
  List<Server> listServers;

  AllServerStatus({
    required this.listServers,
  });

  @override
  _AllServerStatusState createState() => _AllServerStatusState();
}

// class _MainPageState extends State<MainPage> {
//   bool value = true;

class _AllServerStatusState extends State<AllServerStatus> {
  void ChangeVolume(List<Server> listServers, Server server, double index) {
    // writeCellValue(index.toStringAsFixed(2), server.id, 1);
    SendAudioOSC(listServers, index);
    // if (room.resolume) {
    // } else {
    //   SendUDPAudioMessage(server, index);
    // }
    server.volume = (index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(
      widget.listServers!.length,
      (index) => Container(
        alignment: Alignment.center,
        width: 140,
        height: 45,
        margin: EdgeInsets.fromLTRB(20 , 10, 20, 0),
        decoration: BoxDecoration(
            color: widget.listServers![index].connected
                ? AppColors.green
                : AppColors.red,
            borderRadius: BorderRadius.circular(15)),
        child: PrimaryText(
          text: widget.listServers![index].shotname,
          size: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    ));
  }
}
