import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'gradientCircularProgressIndicator.dart';

class GradientCircularProgressRoute extends StatefulWidget {
  @override
  _GradientCircularProgressState createState() =>
      _GradientCircularProgressState();
}

class _GradientCircularProgressState
    extends State<GradientCircularProgressRoute> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    bool _isForward = true;

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        _isForward = true;
      } else if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _isForward ? _controller.reverse() : _controller.forward();
      } else if (status == AnimationStatus.reverse) {
        _isForward = false;
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: <Widget>[
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 16.0,
                        children: <Widget>[
                          GradientCircularProgressIndicator(
                            //No gradient
                            colors: <Color>[Colors.blue, Colors.blue],
                            radius: 50.0,
                            strokeWidth: 5.0,
                            value: _controller.value,
                          ),
                          GradientCircularProgressIndicator(
                            colors: <Color>[Colors.red, Colors.orange],
                            strokeWidth: 5.0,
                            radius: 50.0,
                            value: _controller.value,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
