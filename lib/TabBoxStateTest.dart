import 'package:flutter/material.dart';

class TapBoxA extends StatefulWidget {
  TapBoxA({Key key}) : super(key: key);

  @override
  _TapBoxState createState() => _TapBoxState();
}

class _TapBoxState extends State<TapBoxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Center(
        child: Container(
          child: Text(
            _active ? '激活' : '禁用',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
            textDirection: TextDirection.ltr,
          ),
          alignment: Alignment.center,
          width: 200.0,
          height: 200.0,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: _active ? Colors.lightGreen[700] : Colors.grey[600],
          ),
        ),
      ),
    );
  }
}

//*************以下是父Widget管理子Widget的状态示例***************
class MyParentWidgt extends StatefulWidget {
  MyParentWidgt({Key key}) : super(key: key);
  @override
  _ParentState createState() {
    return _ParentState();
  }
}

class _ParentState extends State<MyParentWidgt> {
  var _activate = false;
  void _onChanged(bool value) {
    setState(() {
      _activate = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TapBoxB(
      activate: _activate,
      onChanged: _onChanged,
    );
  }
}

class TapBoxB extends StatelessWidget {
  TapBoxB({Key key, this.activate: false, @required this.onChanged})
      : super(key: key) {
    print('create TapBoxB activate = $activate');
  }
  final bool activate;
  final ValueChanged<bool> onChanged;

  void _changeTap() => onChanged(!activate);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _changeTap,
      child: Center(
        child: Container(
          child: Text(
            activate ? 'activate' : 'deactivate',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
            textDirection: TextDirection.ltr,
          ),
          width: 200.0,
          height: 200.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: activate ? Colors.lightBlue[700] : Colors.grey[600],
          ),
        ),
      ),
    );
  }
}

//***************混合模式：父和子Widget共同管理子Widge状态******************
class ParentCWidget extends StatefulWidget {
  ParentCWidget({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ParentCWidgetState();
  }
}

class _ParentCWidgetState extends State<ParentCWidget> {
  bool _activate = false;

  void onChanged(bool value) {
    setState(() {
      _activate = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TapBoxC(
      activate: _activate,
      onChanged: onChanged,
    );
  }
}

class TapBoxC extends StatefulWidget {
  TapBoxC({Key key, this.activate, this.onChanged}) : super(key: key);

  final bool activate;
  final ValueChanged<bool> onChanged;

  @override
  State<StatefulWidget> createState() => _TapBoxCState();
}

class _TapBoxCState extends State<TapBoxC> {

  bool get activate => widget?.activate;

  void _handleTap() => widget.onChanged(!activate);

  var _highLight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highLight = true;
    });
  }

  void _handelTapUp(TapUpDetails details) {
    setState(() {
      _highLight = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      onTapUp: _handelTapUp,
      onTapDown: _handleTapDown,
      child: Center(
        child: Container(
          alignment: Alignment.center,
          child: Text(
            activate ? '激活' : '禁用',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
            textDirection: TextDirection.ltr,
          ),
          width: 200.0,
          height: 200.0,
          decoration: BoxDecoration(
            color: activate ? Colors.lightGreen[700] : Colors.grey[600],
            border: _highLight
                ? Border.all(color: Colors.teal[700], width: 10.0)
                : null,
          ),
        ),
      ),
    );
  }
}
