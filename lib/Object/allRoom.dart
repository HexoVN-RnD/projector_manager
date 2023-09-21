import 'package:flutter/material.dart';
import 'package:responsive_dashboard/Object/Preset.dart';
import 'package:firedart/firedart.dart';
import 'package:responsive_dashboard/Object/Room.dart';
import 'package:responsive_dashboard/data/data.dart';
import 'package:valuable/valuable.dart';

class AllRoom {
    StatefulValuable<bool> power_all_projectors;
    StatefulValuable<bool> shutter_all_projectors;
    StatefulValuable<bool> power_all_servers;
    StatefulValuable<bool> is_switch_colume;
    StatefulValuable<double> volume_all;
    StatefulValuable<int> current_preset;
    StatefulValuable<int> current_colume;
    StatefulValuable<double> current_transport;
    StatefulValuable<int> num_servers_connected;
    StatefulValuable<int> num_projectors_connected;
    StatefulValuable<int> num_servers;
    StatefulValuable<int> num_sensors;
    StatefulValuable<int> num_leds;
    StatefulValuable<int> num_projectors;
    List<Preset> presets;
    List<Document> allVolumeFB;
    CollectionReference volumeCollection;
    StatefulValuable<String> volumeId;
    // : 1,2,3
    // List<Projector> projectors;
    // List<Server> servers;

    // Constructor
    AllRoom({
        required this.power_all_projectors,
        required this.shutter_all_projectors,
        required this.power_all_servers,
        required this.is_switch_colume,
        required this.volume_all,
        required this.current_preset,
        required this.current_colume,
        required this.current_transport,
        required this.presets,
        required this.num_servers_connected,
        required this.num_projectors_connected,
        required this.num_servers,
        required this.num_sensors,
        required this.num_leds,
        required this.num_projectors,
        required this.allVolumeFB,
        required this.volumeCollection,
        required this.volumeId,
    });

    void setAllVolume() async {
        // List<Document> allVolume =
        allVolumeFB = await volumeCollection.orderBy('allVolume').get();
        final check = allVolumeFB.map((volume) {
            volumeId.setValue(volume.id);
            print('volumeId: ${volumeId.getValue()}');
            final checkVolume = volume['allVolume'].toString();
            print('allVolume: $checkVolume');
            volume_all.setValue((double.tryParse(checkVolume.toString())??0.0));
            return [volumeId.getValue(), checkVolume];
        });
        print('allVolume: ${check}');
    }

    void updateAllVolume(double allVolumeValue) async {
        // volumeId = allVolume.id;
        // print('ENLH4hL9FNkV87USu2Iv');
        await volumeCollection.document(volumeId.getValue()).update({
            // await volumeCollection.document(volumeId!).update({
            'allVolume': allVolumeValue,
        });
        for (Room room in rooms){
            await room.roomVolumeCollection.document(volumeId.getValue()).update({
                // await roomVolumeCollection.document(roomVolumeId!).update({
                room.nameDatabase : allVolumeValue,
                //   'volumeP3' : roomVolumeValue,
            });
        }
    }
}
