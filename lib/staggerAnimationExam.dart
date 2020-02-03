import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({Key key, @required this.controller})
      : assert(controller != null),
        _height = Tween(begin: 0.0, end: 300.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.6, curve: Curves.ease),
          ),
        ),
        _color = ColorTween(begin: Colors.green, end: Colors.red).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.6, curve: Curves.ease),
          ),
        ),
        _padding = EdgeInsetsTween(
                begin: EdgeInsets.only(left:0.0),
                end: EdgeInsets.only(left: 250.0))
            .animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.6, 1.0, curve: Curves.ease),
          ),
        ),
        super(key: key);

  final AnimationController controller;
  final Animation<double> _height;
  final Animation<Color> _color;
  final Animation<EdgeInsets> _padding;

  Widget _buildAnimationWidget(BuildContext context, Widget child) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: _padding.value,
      child: Container(
        color: _color.value,
        width: 50.0,
        height: _height.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimationWidget,
      animation: controller,
    );
  }
}

class StaggerRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StaggerRouteState();
}

class _StaggerRouteState extends State<StaggerRoute>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    super.initState();
  }

  Future<Null> _playAnimation() async {
    try {
      await _controller.forward();
      await _controller.reverse();
    } on TickerCanceled {}
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _playAnimation,
      child: Center(
        child: Container(
          width: 300.0,
          height: 300.0,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: Colors.grey[600],
          ),
          child: StaggerAnimation(controller: _controller),
        ),
      ),
    );
  }
}
