import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FutureBuilderRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FutureBuilderRouteState();
}

class _FutureBuilderRouteState extends State<FutureBuilderRoute> {
  Dio _dio = new Dio();

  Future _dioGet() {
    _dio.options.headers[HttpHeaders.userAgentHeader] ??=
        'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1';
    return _dio.get('https://www.baidu.com');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: FutureBuilder(
            future: _dioGet(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Response response = snapshot.data;
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (response.data is Set) {
                  return ListView(
                    children: response.data
                        .map<Widget>(
                            (e) => ListTile(title: Text(e['full_name'])))
                        .toList(),
                  );
                } else
                  return Builder(
                      builder: (context) => Container(
                            alignment: Alignment.topLeft,
                            width: MediaQuery.of(context).size.width - 100,
                            child: Text(response.data),
                          ));
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
