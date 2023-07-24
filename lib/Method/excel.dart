// import 'dart:io';
// import 'package:path/path.dart';
// import 'package:excel/excel.dart';
// import 'package:flutter/services.dart' show ByteData, rootBundle;
//
// Future<double> readCellValue(int row, int column) async {
//   ByteData data = await rootBundle.load('assets/excel/volume.xlsx');
//   var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
//   var excel = Excel.decodeBytes(bytes);
//   SharedString a;
//   var table = excel.tables.keys.first;
//   // print(table); //sheet Name
//   // print(excel.tables[table]?.maxCols);
//   // print(excel.tables[table]?.maxRows);
//   var row_value = excel.tables[table]!.rows[row];
//   print(row_value[column]?.value);
//   var value = await row_value[column]?.value;
//   double last_value = double.parse(value.toString());
//   return last_value ?? 0.0;
//   // Trả về giá trị của ô B1, nếu không có giá trị trả về chuỗi rỗng
// }
//
// void writeCellValue(String value, int row, int column) async {
//   String file_name = 'assets/excel/volume.xlsx';
//   File file = File(file_name);
//   List<int>? bytes = file.readAsBytesSync();
//   Excel excel = Excel.decodeBytes(bytes);
//
//   Sheet sheet = excel['Sheet1'];
//   sheet.updateCell(
//       CellIndex.indexByColumnRow(columnIndex: column, rowIndex: row), value);
//
//   // Lưu file Excel
//   //stopwatch.reset();
//   // file.writeAsBytesSync(excel.encode());
//   List<int>? fileBytes = excel.save();
//   //print('saving executed in ${stopwatch.elapsed}');
//   if (fileBytes != null) {
//     File(join(file_name))
//       ..createSync(recursive: true)
//       ..writeAsBytesSync(fileBytes);
//   }
// }
