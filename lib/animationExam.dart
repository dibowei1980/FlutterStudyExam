import 'package:flutter/material.dart';

class ScaleAnimationRoute extends StatefulWidget {
  @override
  _ScaleAnimationRouteState createState() {
    return _ScaleAnimationRouteState();
  }
}

class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  _ScaleAnimationRouteState({Key key, this.duration = 3});

  final int duration;
  Animation<double> _animation;
  AnimationController _animationController;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: this.duration),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.ease,
    );
    _animation = Tween(begin: 0.0, end: 800.0).animate(_animation)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Image.asset(
        'images/test.jpg',
        width: _animation.value,
        height: _animation.value,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
