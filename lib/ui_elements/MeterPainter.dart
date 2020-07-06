import 'package:flutter/material.dart';
import 'dart:math';

class MeterPainter extends CustomPainter {
  double _yellowCirclefraction;
  double _redCirclefraction;
  double _greenCirclefraction;

  MeterPainter(this._yellowCirclefraction, this._redCirclefraction,
      this._greenCirclefraction);
  Path getWheelPath(double wheelSize, double fromRadius, double toRadius) {
    return new Path()
      ..moveTo(wheelSize, wheelSize)
      ..arcTo(
          Rect.fromCircle(
              radius: wheelSize, center: Offset(wheelSize, wheelSize)),
          fromRadius,
          toRadius,
          false)
      ..close();
  }

  //you can customise this width according to your need...
  double width = 15;
  double widthDark = 2;
  Paint getColoredPaint(Color color) {
    Paint paint = Paint();
    paint.color = color;
    return paint;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
      ..color = Colors.transparent
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    Paint firstOfThree = new Paint()
      ..color = Color(0xFFf1c40f)
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Paint secondOfThree = new Paint()
      ..color = Color(0xFFe74c3c)
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Paint thirdOfThree = new Paint()
      ..color = Color(0xFF2ecc71)
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    //the dark arcs overlay paints..
    Paint firstOfThreeDark = new Paint()
      ..color = Color(0xFFf1c40f)
      ..style = PaintingStyle.stroke
      ..strokeWidth = widthDark;
    Paint secondOfThreeDark = new Paint()
      ..color = Color(0xFFe74c3c)
      ..style = PaintingStyle.stroke
      ..strokeWidth = widthDark;
    Paint thirdOfThreeDark = new Paint()
      ..color = Color(0xFF2ecc71)
      ..style = PaintingStyle.stroke
      ..strokeWidth = widthDark;

    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    double sweepAngle = pi;
    canvas.drawCircle(center, radius, line);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius + 8),
        -(pi) / 2, (sweepAngle / 2) *_yellowCirclefraction, false, firstOfThree);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius + 8), -2 * pi,
     (sweepAngle / 2) * _redCirclefraction, false, secondOfThree);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius + 8),
        -(3 * pi) / 2, (sweepAngle) * _greenCirclefraction, false, thirdOfThree);
    

    //the dark arcs overlay...
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius + 8),
        -(pi) / 2, sweepAngle / 2, false, firstOfThreeDark);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius + 8),
        -(2 * pi), sweepAngle / 2, false, secondOfThreeDark);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius + 8),
        -(3 * pi) / 2, sweepAngle, false, thirdOfThreeDark);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

@override
Widget ingridientsView(List<String> ingredients) {
  List<Widget> children = new List<Widget>();
  ingredients.forEach((item) {
    children.add(
      new Row(
        children: <Widget>[
          new Icon(Icons.done),
          new SizedBox(width: 5.0),
          new Text(item.toString()),
        ],
      ),
    );
    // Add spacing between the lines:
    children.add(
      new SizedBox(
        height: 5.0,
      ),
    );
  });
  return ListView(
    shrinkWrap: true,
    physics: ClampingScrollPhysics(),
    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
    children: children,
  );
}
