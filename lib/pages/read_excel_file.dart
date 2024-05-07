import 'package:flutter/material.dart';
import 'package:speaking_english_model_app/pages/article_topic.dart';
import 'package:speaking_english_model_app/pages/body_myhome_page.dart';
import 'package:speaking_english_model_app/pages/topic_page.dart';
import 'package:speaking_english_model_app/pages/topics.dart';

import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excel Reader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExcelReader(),
    );
  }
}

class ExcelReader extends StatefulWidget {
  @override
  _ExcelReaderState createState() => _ExcelReaderState();
}

class _ExcelReaderState extends State<ExcelReader> {
  List<dynamic> _excelData = [];

  Future<void> _readExcel() async {
    // Đọc file Excel từ tệp 'data.xlsx' trong thư mục assets
    var bytes = File('assets/book1.xlsx').readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    // Lấy sheet đầu tiên từ file Excel
    var sheet = excel.tables.keys.first;
    var table = excel.tables[sheet];

    // Xóa dữ liệu cũ
    _excelData.clear();

    // Lấy dữ liệu từ mỗi dòng, chỉ lấy ô đầu tiên của mỗi dòng
    for (var row in table!.rows) {
      // Nếu dòng không có dữ liệu, bỏ qua
      if (row.isEmpty) continue;
      
      _excelData.add(row[0]);
    }

    // Hiển thị dữ liệu
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _readExcel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Excel Reader'),
      ),
      body: Center(
        child: _excelData.isEmpty
            ? CircularProgressIndicator() // Hiển thị tiến trình khi đang đọc dữ liệu
            : ListView.builder(
                itemCount: _excelData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_excelData[index].toString()),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _readExcel(); // Khi nhấn vào nút, cập nhật dữ liệu từ file Excel
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
