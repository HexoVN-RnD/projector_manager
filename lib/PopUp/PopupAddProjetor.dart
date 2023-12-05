// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:responsive_dashboard/Object/roomData.dart';
// import 'package:responsive_dashboard/PopUp/customRectTween.dart';
// import 'package:responsive_dashboard/main.dart';
// import 'package:responsive_dashboard/style/colors.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// const String heroAddRoomTest = 'popupRoomTest';
//
// class PopupAddRoomTest extends StatefulWidget {
//   const PopupAddRoomTest({Key? key}) : super(key: key);
//
//   @override
//   State<PopupAddRoomTest> createState() => _PopupAddRoomTestState();
// }
//
// class _PopupAddRoomTestState extends State<PopupAddRoomTest> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController roomDataController = TextEditingController();
//   List<RoomData> roomData = List.empty(growable: true);
//
//   int selectedIndex = -1;
//
//   late SharedPreferences pref;
//
//   getSharedPrefrences() async {
//     pref = await SharedPreferences.getInstance();
//     readFromSp();
//   }
//
//   saveIntoSp() {
//     //
//     List<String> roomDataListString =
//         roomData.map((roomData) => jsonEncode(roomData.toJson())).toList();
//     pref.setStringList('myData', roomDataListString);
//     //
//   }
//
//   readFromSp() {
//     //
//     List<String>? roomDataListString = pref.getStringList('myData');
//     if (roomDataListString != null) {
//       roomData = roomDataListString
//           .map((roomData) => RoomData.fromJson(json.decode(roomData)))
//           .toList();
//     }
//     setState(() {});
//     //
//   }
//
//   @override
//   void initState() {
//     getSharedPrefrences();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final width = 600.0;
//     final height = 600.0;
//     return Hero(
//       tag: heroAddRoomTest,
//       createRectTween: (begin, end) {
//         return CustomRectTween(begin: begin, end: end);
//       },
//       child: SingleChildScrollView(
//       child: Material(
//       child: Container(
//       width: width,
//       height: height,
//       decoration: BoxDecoration(
//           color: AppColors.white,
//           borderRadius: BorderRadius.circular(30)),
//         child:  Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               const SizedBox(height: 10),
//               TextField(
//                 controller: nameController,
//                 decoration: const InputDecoration(
//                     hintText: 'roomData Name',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(10),
//                         ))),
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 controller: roomDataController,
//                 keyboardType: TextInputType.number,
//                 maxLength: 10,
//                 decoration: const InputDecoration(
//                     hintText: 'roomData Number',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(10),
//                         ))),
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                       onPressed: () {
//                         //
//                         String name = nameController.text.trim();
//                         String roomText = roomDataController.text.trim();
//                         if (name.isNotEmpty && roomText.isNotEmpty) {
//                           setState(() {
//                             nameController.text = '';
//                             roomDataController.text = '';
//                             roomData.add(RoomData(
//                                 nameUI: nameController.text,
//                                 nameDatabase: roomDataController.text,
//                                 power_room_projectors: false,
//                                 shutter_room_projectors: false,
//                                 isSelectedPlay: false,
//                                 isSelectedStop: false,
//                                 resolume: false,
//                                 map: '',
//                                 general: '',
//                                 current_preset: 10,
//                                 roomVolumeId: ''));
//                           });
//                           // Saving roomData list into Shared Prefrences
//                           saveIntoSp();
//                         }
//                         //
//                       },
//                       child: const Text('Save')),
//                   ElevatedButton(
//                       onPressed: () {
//                         //
//                         String name = nameController.text.trim();
//                         String roomText = roomDataController.text.trim();
//                         if (name.isNotEmpty && roomData.isNotEmpty) {
//                           setState(() {
//                             nameController.text = '';
//                             roomDataController.text = '';
//                             roomData[selectedIndex].nameUI = name;
//                             roomData[selectedIndex].general = roomText;
//                             selectedIndex = -1;
//                           });
//                           // Saving roomData list into Shared Prefrences
//                           saveIntoSp();
//                         }
//                         //
//                       },
//                       child: const Text('Update')),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               roomData.isEmpty
//                   ? const Text(
//                 'No roomData yet..',
//                 style: TextStyle(fontSize: 22),
//               )
//                   : Expanded(
//                 child: ListView.builder(
//                   itemCount: roomData.length,
//                   itemBuilder: (context, index) => getRow(index),
//                 ),
//               )
//             ],
//           ),
//         )
//       ),
//     ),),);
//   }
//
//   Widget getRow(int index) {
//     return Card(
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor:
//               index % 2 == 0 ? Colors.deepPurpleAccent : Colors.purple,
//           foregroundColor: Colors.white,
//           child: Text(
//             roomData[index].nameUI[0],
//             style: const TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ),
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               roomData[index].nameUI,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(roomData[index].general),
//           ],
//         ),
//         trailing: SizedBox(
//           width: 70,
//           child: Row(
//             children: [
//               InkWell(
//                   onTap: () {
//                     //
//                     nameController.text = roomData[index].nameUI;
//                     roomDataController.text = roomData[index].general;
//                     setState(() {
//                       selectedIndex = index;
//                     });
//                     //
//                   },
//                   child: const Icon(Icons.edit)),
//               InkWell(
//                   onTap: (() {
//                     //
//                     setState(() {
//                       roomData.removeAt(index);
//                     });
//                     // Saving roomData list into Shared Prefrences
//                     saveIntoSp();
//                     //
//                   }),
//                   child: const Icon(Icons.delete)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
