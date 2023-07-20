import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';

double readCellValue(int row, int column) {
  var file = 'assets/excel/volume.xlsx';
  var bytes = File(file).readAsBytesSync();
  var excel = Excel.decodeBytes(bytes);

  // Tên của bảng trong file Excel
  var tableName = excel.tables.keys.first;

  // Lấy giá trị của ô B1
  var cellValue = double.parse(excel.tables[tableName]!.rows[row][column]?.value);

  return cellValue ?? 0.0 ; // Trả về giá trị của ô B1, nếu không có giá trị trả về chuỗi rỗng
}

void writeCellValue(String value, int row, int column) async {
  String file_name = 'assets/excel/volume.xlsx';
  File file = File(file_name);
  List<int>? bytes = file.readAsBytesSync();
  Excel excel = Excel.decodeBytes(bytes);

  Sheet sheet = excel['Sheet1'];
  sheet.updateCell(CellIndex.indexByColumnRow(columnIndex: column, rowIndex: row), value);

  // Lưu file Excel
  //stopwatch.reset();
  // file.writeAsBytesSync(excel.encode());
  excel.save(fileName: file_name);
  //print('saving executed in ${stopwatch.elapsed}');
  // if (fileBytes != null) {
  //   File(join(file_name))
  //     ..createSync(recursive: true)
  //     ..writeAsBytesSync(fileBytes);
  // }
}

