import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/data/Shared_pref.dart';

import '../Method/Osc_void.dart';
import '../Method/udp_void.dart';
import '../Object/Server.dart';
import '../config/size_config.dart';
import '../dashboard.dart';
import '../data/data.dart';
import '../style/colors.dart';

class PresetUI extends StatefulWidget {
  int index;
  @override
  PresetUI({
    Key? key,
    required this.index,
  });
  @override
  State<PresetUI> createState() => _PresetUIState();
}

class _PresetUIState extends State<PresetUI> {
  Room room = rooms[0];
  bool editing = false;
  TextEditingController namePreset = TextEditingController();
  void select_preset(Room room, int index) async {
    setState(() {
      room.current_preset.setValue(index);
      for (Server server in room.servers) {
        if (room.resolume) {
          SendPresetOSC(
              server.ip, server.preset_port, room.current_preset.getValue());
          PlayPreset(current_page.getValue());
        } else {
          SendUDPMessage(server,
              'Preset' + (room.current_preset.getValue() + 1).toString());
        }
      }
    });
  }
  @override
  void initState(){
    super.initState();
    namePreset.text = room.presets[widget.index].name;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected = room.current_preset.getValue() == widget.index;

    // namePreset.text = room.presets[widget.index].name;
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(bottom: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              select_preset(room, widget.index);
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              width: isSelected ? 180.0 : 120.0,
              height: isSelected ? 180.0 : 120.0,
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.yellow4 : AppColors.navy_blue2,
                borderRadius: BorderRadius.circular(isSelected ? 20.0 : 15),
              ),
              child: Padding(
                padding: EdgeInsets.all(isSelected ? 8.0 : 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(isSelected ? 15.0 : 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isSelected)
                        SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
                      AnimatedDefaultTextStyle(
                        style: isSelected
                            ? TextStyle(
                          color: AppColors.white,
                                fontFamily: 'Poppins',
                                fontSize: 60.0,
                                fontWeight: FontWeight.w600)
                            : TextStyle(

                            color: AppColors.white,
                                fontFamily: 'Poppins',
                                fontSize: 38.0,
                                fontWeight: FontWeight.w600),
                        duration: const Duration(milliseconds: 200),
                        child: Text((widget.index + 1).toString()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isSelected)
            SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedDefaultTextStyle(
                style: isSelected
                    ? TextStyle(
                        color: AppColors.white,
                        fontFamily: 'Poppins',
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600)
                    : TextStyle(
                        color: AppColors.white,
                        fontFamily: 'Poppins',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600),
                duration: const Duration(milliseconds: 200),
                child: editing
                    ? Container(
                        constraints: BoxConstraints(
                          minHeight: 80.0,
                          maxHeight: 180.0,
                        ),
                        width: isSelected ? 180.0 : 120.0,
                        child: TextFormField(
                          controller: namePreset,
                          style: TextStyle(color: AppColors.white, fontSize: 14),
                          cursorColor: AppColors.navy_blue,
                          minLines: 1,
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: 'Tên video',
                            labelStyle: TextStyle(color: AppColors.white),
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.check,
                                color: AppColors.navy_blue,
                              ),
                              onPressed: () {
                                setState(() {
                                  room.presets[widget.index].name =
                                      namePreset.text;
                                  SaveData('presets_name_${widget.index}', namePreset.text);
                                  print(namePreset.text);
                                  print(room.presets[widget.index].name);
                                  editing = false;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 3.0,
                              ),
                              borderRadius: BorderRadius.circular(
                                  isSelected ? 20.0 : 15),
                            ),
                            // Customize the focused border thickness
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  isSelected ? 20.0 : 15),
                              borderSide: BorderSide(
                                color: AppColors.white,
                                width: 3.0,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        alignment: Alignment.center,
                        constraints: BoxConstraints(
                          minHeight: 50.0,
                          // maxHeight: 180.0,
                        ),
                        width: isSelected ? 180.0 : 120.0,
                        child: GestureDetector(
                            onDoubleTap: () {
                              editing = true;
                              setState(() {
                                print(editing);
                              });
                            },
                            child: room.presets[widget.index].name.trim().isEmpty
                                ? Icon(Icons.edit, color: AppColors.white,)
                                : Text(
                                    room.presets[widget.index].name,
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontFamily: 'Poppins',
                                        fontSize: isSelected? 14: 12.0,
                                        fontWeight: FontWeight.w600),
                                  )),
                      ),
              ),
              // PrimaryText(
              //     text: room.presets[widget.index].name,
              //     size: isSelected ? 17 : 12,
              //     color: AppAppColors.white,
              //     fontWeight: FontWeight.w600),
            ],
          ),
        ],
      ),
    );
  }
}
