import 'dart:math';
import 'dart:ui';
import 'package:drawing_app/created_classes/options.dart';
import 'package:flutter/material.dart';
import '../model.dart';

mixin DrawingPainterMethods{
  drawFigure(Canvas canvas,Paint paint,Offset point1,Offset point2,{Option option = Option.circle,Offset controlPoint,MyModel model}){
    double x = point2.dx - point1.dx;
    double y = point2.dy - point1.dy;
    Offset center = Offset(point1.dx + x * 0.5, point1.dy + y * 0.5);
    double radius = 0.5 * sqrt(x * x + y * y);
    if(option == Option.circle) {
      canvas.drawCircle(center, radius, paint);
    }else if (option == Option.square){
      Rect rect = Rect.fromCircle(center: center,radius: radius);
      canvas.drawRect(rect, paint);
    }else if (option == Option.oval){
      Rect rect = Rect.fromCenter(center: center,width: x,height: y);
      canvas.drawOval(rect, paint);
    }else if (option == Option.rectangle){
      Rect rect = Rect.fromCenter(center: center,width: x,height: y);
      canvas.drawRect(rect, paint);
    }else if(option == Option.path){
      drawCurve(point1, controlPoint, center, radius, point2, canvas, paint, model);
    }else if(option == Option.triangle){
      drawTriangle(point1, point2, controlPoint, canvas, paint, model);
    }
    else if(option == Option.line){
      drawLine(canvas, point1, point2, paint, model);
    }


  }

  void drawLine(Canvas canvas, Offset point1, Offset point2, Paint paint, MyModel model) {
    canvas.drawLine(point1, point2, paint);
    model.changeGuides(false);

  }

  void drawTriangle(Offset point1, Offset point2, Offset controlPoint, Canvas canvas, Paint paint, MyModel model) {
    var vertices = Vertices(VertexMode.triangles, [point1,point2,controlPoint]);
    canvas.drawVertices(vertices, BlendMode.clear, paint);
    model.changeGuides(false);

  }

  void drawCurve(Offset point1, Offset controlPoint, Offset center, double radius, Offset point2, Canvas canvas, Paint paint, MyModel model) {
    Path path = Path();
    path.moveTo(point1.dx, point1.dy);
    path.quadraticBezierTo(controlPoint.dx??center.dx + radius, controlPoint.dy ??center.dy + radius, point2.dx, point2.dy);
    canvas.drawPath(path, paint);
    path.reset();
    model.changeGuides(false);

  }
}