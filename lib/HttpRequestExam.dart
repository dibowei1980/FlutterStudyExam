import 'dart:io';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HttpRequestExamRoute extends StatefulWidget {
  HttpRequestExamRoute({Key key}) : super(key: key);

  @override
  _HttpRequestExamState createState() => _HttpRequestExamState();
}

class _HttpRequestExamState extends State<HttpRequestExamRoute> {
  bool _loading = false;
  String _text = '';

  void _getHttpString() async {
    if (!_loading) {
      _loading = true;
      setState(() {});
      var httpClient = HttpClient();

      var request = await httpClient.getUrl(Uri.parse('https://www.baidu.com'));
      request.headers.add('user-agent',
          'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1');
      var response = await request.close();
      _text = await response.transform(utf8.decoder).join();
      _loading = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _getHttpString();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTTP测试',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Http测试'),
        ),
        body: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                RaisedButton(
                  child: Text('点击获取百度Http'),
                  onPressed: _loading ? null : _getHttpString,
                ),
                Builder(
                  builder: (context) => Container(
                    width: MediaQuery.of(context).size.width - 100,
                    child: Text(
                      _text,
                      textAlign: TextAlign.left,
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
