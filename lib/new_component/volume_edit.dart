import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_dashboard/Method/Osc_void.dart';
import 'package:responsive_dashboard/Method/audio_void.dart';
import 'package:responsive_dashboard/Method/excel.dart';
import 'package:responsive_dashboard/Method/projector_command.dart';
import 'package:responsive_dashboard/Method/udp_void.dart';
import 'package:responsive_dashboard/Object/BrightSign.dart';
import 'package:responsive_dashboard/Object/Projector.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/Object/Server.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';

class VolumeEdit extends StatefulWidget {
  // Room room;
  Server server;

  VolumeEdit({
    // required this.room,
    required this.server,
  });

  @override
  _VolumeEditState createState() => _VolumeEditState();
}

// class _MainPageState extends State<MainPage> {
//   bool value = true;

class _VolumeEditState extends State<VolumeEdit> {
  void ChangeVolume(Room room, Server server, double index) {
    // writeCellValue(index.toStringAsFixed(2), server.id, 1);
    // room.updateRoomVolume(index);
    print('volumeP${current_page }'+index.toString());
    if (room.resolume) {
      SendAudioOSC(room, index);
    } else {
      for (BrightSign brightSign in room.brightSign!) {
        SendUDPAudioMessage(brightSign, index);
      }
    }
    server.volume = index;
  }

  @override
  Widget build(BuildContext context) {
    // Room room = widget.room;
    Server server = widget.server;
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                room.isSelectedStop = true;
                room.isSelectedPlay = false;
                StopPreset(current_page );
                // for (Server server in rooms[0].servers) {
                //   SendUDPMessage(server, 'Preset0');
                // }
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  width: 65.0,
                  height: 50.0,
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: room.isSelectedStop 
                        ? AppColors.navy_blue2
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    Icons.pause,
                    size: 32,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                room.isSelectedPlay = true;
                room.isSelectedStop = false;
                PlayPreset(current_page );
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  width: 65.0,
                  height: 50.0,
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: room.isSelectedPlay 
                        ? AppColors.navy_blue2
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    size: 32,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          // Expanded(child: SizedBox()),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 1,
          ),
          // Container(
          //   width: 90, //widget.room.resolume? 380:230,
          //   child: PrimaryText(
          //     text: "Âm thanh ", // + server.name,
          //     color: AppColors.white,
          //     size: 18,
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
          // SizedBox(
          //   width: SizeConfig.blockSizeHorizontal,
          // ),
          Icon(
            (server.volume  != 0)
                ? Icons.music_note
                : Icons.music_off,
            size: 25,
            color: AppColors.white,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
              // width: 400,
              child: Transform.scale(
                scale: 1,
                child: Slider(
                  activeColor: AppColors.navy_blue,
                  inactiveColor: AppColors.light_navy_blue,
                  value: server.volume ,
                  onChanged: (index) {
                    setState(() {
                      server.volume = index;
                    });
                  },
                  onChangeEnd: (index) {
                    setState(() => ChangeVolume(room, server, index));
                  },
                  min: 0,
                  max: 1,
                  // divisions: 5,
                ),
              ),
            ),
          ),
          PrimaryText(
              text: (server.volume  * 100).toStringAsFixed(0),
              color: AppColors.barBg,
              size: 16),
        ],
      ),
    );
  }
}
