import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class StartPagePainter extends CustomPainter{

  List<Offset> trianglePoints = [
    Offset(142.9, 177.8),
    Offset(283.3, 282.1),
    Offset(129.4, 367.6)
    //Offset(),
  ];
  List<Offset> trianglePoints2 = [
    Offset(55.9, 293.8),
    Offset(108.8, 206.8),
    Offset(167.8, 296.8)
    //Offset(),
  ];
  List<Offset> pathPoints = [
    Offset(134.9, 159.3),
    Offset(222.9, 195.3),
    Offset(256.3, 85.8)
    //Offset(),
  ];
  List<Offset> circlePoints = [
    Offset(233.8, 501.4),
    Offset(275.3, 537.4),
    //Offset(),
  ];
  double get(String direction,int index){
    if(direction=='x') return pathPoints[index].dx;
    else return pathPoints[index].dy;
  }
  @override
  void paint(Canvas canvas, Size size) {
    Offset point1 = circlePoints[0];Offset point2 = circlePoints[1];

    double x = point2.dx - point1.dx;
    double y = point2.dy - point1.dy;
    Offset center = Offset(point1.dx + x * 0.5, point1.dy + y * 0.5);
    double radius = 0.5 * sqrt(x * x + y * y);
    Paint paint = Paint()
      ..strokeCap = StrokeCap.butt
      ..isAntiAlias = true
      ..color = Colors.green
      ..strokeWidth = 5;
    drawTriangles(canvas, paint);
    canvas.drawCircle(center, radius, paint..color=Colors.pink);
    drawCurve(canvas, paint);
  }

  void drawTriangles(Canvas canvas, Paint paint) {
    canvas.drawVertices(Vertices(VertexMode.triangles, trianglePoints), BlendMode.clear, paint);
    canvas.drawVertices(Vertices(VertexMode.triangles, trianglePoints2), BlendMode.clear, paint..color=Colors.purple);
  }

  void drawCurve(Canvas canvas, Paint paint) {
    Path path = Path();
    path.moveTo(get('x', 0), get('y', 0));
    path.quadraticBezierTo(get('x', 1), get('y', 1), get('x', 2), get('y', 2));
    canvas.drawPath(path, paint..color = Colors.amber..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}