import 'dart:ui';

import 'package:drawing_app/options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'drawing_points.dart';
import 'dart:math';

class DrawingPainter extends CustomPainter {


  DrawingPainter( {this.pointsList});
  List<DrawingPoints> pointsList;
  List<Offset> offsetPoints = List();
  drawFigure(Canvas canvas,Paint paint,Offset point1,Offset point2,{Option option = Option.CIRCLE}){
    double x = point2.dx - point1.dx;
    double y = point2.dy - point1.dy;
    Offset center = Offset(point1.dx + x * 0.5, point1.dy + y * 0.5);
    double radius = 0.5 * sqrt(x * x + y * y);
  if(option == Option.CIRCLE) {

    canvas.drawCircle(center, radius,
        paint);
  }else if (option == Option.SQUARE){
    Rect rect = Rect.fromCircle(center: center,radius: radius);
    canvas.drawRect(rect, paint);
  }

  }

  DrawingPoints startPoint ;
  DrawingPoints endPoint ;
  @override
  void paint(Canvas canvas, Size size) {

      for (int i = 0; i < pointsList.length - 1; i++) {
         DrawingPoints currentPoint= pointsList[i];
         DrawingPoints nextPoint= pointsList[i + 1];
         endPoint = currentPoint;
         if(currentPoint.type == PointType.Start)startPoint=currentPoint;

         if(currentPoint.drawingOption == Option.CIRCLE){
           drawFigure(canvas, currentPoint.paint, startPoint.points, currentPoint.points);
         }
         if(currentPoint.drawingOption == Option.SQUARE){
           drawFigure(canvas, currentPoint.paint, startPoint.points, currentPoint.points,option: Option.SQUARE);
         }

        if (currentPoint.type != PointType.End && nextPoint.type != PointType.End  && currentPoint.drawingOption == Option.HAND) {
          canvas.drawLine(currentPoint.points, nextPoint.points, currentPoint.paint);
        }

        else if (currentPoint.type != PointType.End  && nextPoint.type == PointType.End  && currentPoint.drawingOption == Option.HAND) {
          offsetPoints.clear();
          offsetPoints.add(currentPoint.points);
          offsetPoints.add(Offset(
              currentPoint.points.dx + 0.1, currentPoint.points.dy + 0.1));
          canvas.drawPoints(
              PointMode.points, offsetPoints, currentPoint.paint);
        }

      }


  }
  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}