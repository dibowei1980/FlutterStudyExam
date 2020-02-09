import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class FileOperatorRoute extends StatefulWidget {
  FileOperatorRoute({Key key}) : super(key: key);
  @override
  _FileOperatorState createState() => _FileOperatorState();
}

class _FileOperatorState extends State<FileOperatorRoute> {
  int _count;

  Future<File> _getFile() async {
    String dir;
    dir = await getTemporaryDirectory().then((value) => dir = value.path);
    return File('$dir/count.txt');
  }

  Future<int> _getCount() async {
    try {
      var file = await _getFile();
      var content = await file.readAsString();
      return int.parse(content);
    } on FileSystemException {
      return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    _getCount().then((value) {
      setState(() => _count = value);
    });
  }

  void _increaseCount() async {
    _count++;
    var file = await _getFile();
    await (file.writeAsString('$_count'));
    if (_count >= 10) {
      _count = 0;
      await (file.delete());
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '文件操作测试',
      home: Scaffold(
        appBar: AppBar(
          title: Text('文件操作测试'),
        ),
        body: Center(
          child: Text('$_count',
              style: TextStyle(
                fontSize: 36.0,
              )),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _increaseCount,
        ),
      ),
    );
  }
}
