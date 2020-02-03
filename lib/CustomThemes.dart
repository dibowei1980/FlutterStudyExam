import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:cached_network_image/cached_network_image.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appName = 'Custom Themes';

    return new MaterialApp(
      title: appName,
      theme: new ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
      ),
      home: new MyHomePage(
        title: appName,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: CachedNetworkImage(
          imageUrl:
              'https://pics0.baidu.com/feed/d62a6059252dd42a52788682084b40b3c9eab818.jpeg?token=88e4b7125de7c1bd273dcbb3699f57ab&s=712A6AFA8C3091DC87C0EB0B0300F0D7',
          placeholder:(context,url)=> CircularProgressIndicator(),
          errorWidget: (context,url,error) => Icon(Icons.error),
          fit: BoxFit.contain,
        ),
      ),
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(accentColor: Colors.yellow),
        child: FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.add),
        ),
      ),
    );
    return scaffold;
  }
}
