import 'package:flutter/material.dart';
import 'dart:math';

class CustomPaintRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(300.0, 300.0),
        painter: MyPainter(),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var gridCount = 15;
    var eWidth = size.width / gridCount;
    var eHeight = size.height / gridCount;

    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = Color(0x77cdb175);

    //画背景
    canvas.drawRect(Offset.zero & size, paint);

    //画格网
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.black87
      ..strokeWidth = 2.0;
    for (int i = 0; i < gridCount; ++i) {
      var dy = i * eHeight;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
      var dx = i * eWidth;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }

    //画一个黑棋子
    paint
      ..style = PaintingStyle.fill
      ..color = Colors.black;
    canvas.drawCircle(
        Offset(eWidth * (gridCount / 2).floor(),
            eHeight * (gridCount / 2).floor()),
        min(eWidth, eHeight) / 2,
        paint);

    //画一个白棋子
    paint..color = Colors.white;
    canvas.drawCircle(
        Offset(
            eWidth * (gridCount / 2).ceil(), eHeight * (gridCount / 2).ceil()),
        min(eWidth, eHeight) / 2,
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
