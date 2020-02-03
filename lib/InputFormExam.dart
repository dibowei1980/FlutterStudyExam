import 'package:flutter/material.dart';

class InputFormRouteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('FormField Test'),
        ),
        body: InputFormRouteWidget(),
      ),
    );
  }
}

class InputFormRouteWidget extends StatefulWidget {
  InputFormRouteWidget({Key key}) : super(key: key);
  @override
  _InputFormRouteState createState() => _InputFormRouteState();
}

class _InputFormRouteState extends State<InputFormRouteWidget> {
  var _usnameController = TextEditingController();
  var _pswController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Form(
        key: _formKey,
        autovalidate: false,
        child: Column(
          children: <Widget>[
            TextFormField(
              autofocus: true,
              controller: _usnameController,
              decoration: InputDecoration(
                labelText: '用户名',
                hintText: '用户名或邮箱',
                icon: Icon(Icons.person),
              ),
              validator: (str) {
                return str.trim().length == 0 ? '用户名不能为空' : null;
              },
            ),
            TextFormField(
              autofocus: true,
              controller: _pswController,
              decoration: InputDecoration(
                labelText: '密码',
                hintText: '输入登录密码',
                icon: Icon(Icons.lock),
              ),
              validator: (str) {
                return str.trim().length > 5 ? null : '密码长度不能小于6';
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      padding: EdgeInsets.all(15.0),
                      child: Text('登录(方式一)'),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {}
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Row(children: <Widget>[
                Builder(builder: (context) {
                  return Expanded(
                      child: RaisedButton(
                    padding: EdgeInsets.all(15.0),
                    child: Text('登录(方式二)'),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      if (Form.of(context).validate()) {}
                    },
                  ));
                }),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
