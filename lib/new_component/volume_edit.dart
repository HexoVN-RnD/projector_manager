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
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

class VolumeEdit extends StatefulWidget {
  Room room;
  Server server;

  VolumeEdit({
    required this.room,
    required this.server,
  });

  @override
  _VolumeEditState createState() => _VolumeEditState();
}

// class _MainPageState extends State<MainPage> {
//   bool value = true;

class _VolumeEditState extends State<VolumeEdit> {

  void ChangeVolume(Room room, Server server,double index) {
    writeCellValue(index.toStringAsFixed(2), server.id, 1);
    if (room.resolume) {
      SendAudioOSC(server, index);
    } else {
      SendUDPAudioMessage(server, index);
    }
    server.volume.setValue(index);
  }

  @override
  Widget build(BuildContext context) {
    Room room = widget.room;
    Server server = widget.server;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          (server.volume.getValue() != 0)
              ? Icons.music_note
              : Icons.music_off,
          size: 25,
          color: AppColors.white,
        ),
        SizedBox(
          width: SizeConfig.blockSizeHorizontal,
        ),
        Container(
          width: widget.room.resolume? 200:230,
          child: PrimaryText(
            text: "Âm thanh " + server.name,
            color: AppColors.white,
            size: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(30, 0, 20, 0),
            width: 300,
            child: Transform.scale(
              scale: 1,
              child: Slider(
                activeColor: AppColors.navy_blue,
                inactiveColor: AppColors.light_navy_blue,
                value: server.volume.getValue(),
                onChanged: (index) {
                  server.volume.setValue(index);
                },
                onChangeEnd: (index){
                  setState(() => ChangeVolume(room, server, index));
                },
                min: 0,
                max: 1,
                // divisions: 5,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 30),
          child: PrimaryText(
              text: (server.volume.getValue() * 100)
                  .toStringAsFixed(0),
              color: AppColors.barBg,
              size: 16),
        ),
      ],
    );
  }
}
