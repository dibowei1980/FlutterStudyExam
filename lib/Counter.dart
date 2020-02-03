import 'package:flutter/material.dart';

class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter App Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Flutter App Demo Home Page',
      ),
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) {
          var routeName = routeSettings.name;
          print('context=$context , routeName=$routeName');
          return TipRoute(text: routeName);
        });
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _count = 0;

  void _incrementCount() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('您已经点击按钮次数：'),
            Text('$_count'),
            FlatButton(
                child: Text('打开一个路由'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (content) => NewRout(),
                    ),
                  );
                }),
            RaisedButton(
              child: Text('打开提示页'),
              onPressed: () async {
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TipRoute(text: '我是提示'),
                  ),
                );
                print('路由器返回值：$result');
              },
            ),
            RaisedButton(
              child: Text('测试命名路由'),
              onPressed: () async {
                var result = await Navigator.pushNamed(context, '测试路由');
                print('命名路由返回值: $result');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCount,
        tooltip: '添加',
        child: Icon(Icons.add),
      ),
    );
  }
}

class TipRoute extends StatelessWidget {
  TipRoute({Key key, this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('提示'),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              RaisedButton(
                onPressed: () => Navigator.pop(context, '我是返回值.'),
                child: Text('返回'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NewRout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Route'),
      ),
      body: Center(
        child: Text('This is new route.'),
      ),
    );
  }
}
