import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputBoxExamApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: InputBoxExam(),
      ),
    );
  }
}

class InputBoxExam extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InputBoxExamState();
  }
}

class _InputBoxExamState extends State<InputBoxExam> {
  
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();

  FocusScopeNode focusScopeNode;

  @override
  void initState() {
    super.initState();
    focusNode1.addListener(
        () => print('focusNode1' + (focusNode1.hasFocus ? '获得焦点' : '失去焦点')));
    focusNode2.addListener(
        () => print('focusNode2' + (focusNode2.hasFocus ? '获得焦点' : '失去焦点')));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                autofocus: true,
                focusNode: focusNode1,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: '用户名',
                  hintText: '用户名或邮箱',
                ),
              ),
            ),
            Container(
              child: TextField(
                obscureText: true,
                autofocus: true,
                focusNode: focusNode2,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: '密码',
                  hintText: '您的登录密码',
                ),
              ),
            ),
            Builder(builder: (ctx) {
              return Column(
                children: <Widget>[
                  RaisedButton(
                    child: Text('移动焦点'),
                    onPressed: () {
                      focusNode2.requestFocus();
                    },
                  ),
                  RaisedButton(
                    child: Text('隐藏焦点'),
                    onPressed: () {
                      focusNode1.unfocus();
                      focusNode2.unfocus();
                    },
                  ),
                ],
              );
            }),
          ],
        ),
      // ),
    );
  }
}
