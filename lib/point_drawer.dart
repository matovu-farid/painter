
import 'dart:ui';

import 'package:drawing_app/options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'drawing_points.dart';
import 'dart:math';

class DrawingPainter extends CustomPainter {


  DrawingPainter( {this.pointsList,this.pathPoints,this.linePoints});
  List<DrawingPoints> pointsList;
  List<DrawingPoints> pathPoints;
  List<DrawingPoints> linePoints;

  List<Offset> offsetPoints = List();
  drawFigure(Canvas canvas,Paint paint,Offset point1,Offset point2,{Option option = Option.CIRCLE,Offset controlPoint}){
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
  }else if (option == Option.OVAL){
    Rect rect = Rect.fromCenter(center: center,width: x,height: y);
    canvas.drawOval(rect, paint);
  }else if (option == Option.RECTANGLE){
    Rect rect = Rect.fromCenter(center: center,width: x,height: y);
    canvas.drawRect(rect, paint);
  }else if(option == Option.PATH){
    Path path = Path();
    path.moveTo(point1.dx, point1.dy);
    path.quadraticBezierTo(controlPoint.dx??center.dx + radius, controlPoint.dy ??center.dy + radius, point2.dx, point2.dy);

    canvas.drawPath(path, paint);
    path.reset();
  }else if(option == Option.PENCIL){
    canvas.drawLine(point1, point2, paint);
  }


  }

  DrawingPoints startPoint ;
  DrawingPoints endPoint ;

  DrawingPoints startCurvePoint ;
  DrawingPoints endCurvePoint ;
  DrawingPoints controlCurvePoint ;


  @override
  void paint(Canvas canvas, Size size) {
      for (int i = 0; i < pointsList.length - 1; i++) {
         DrawingPoints currentPoint= pointsList[i];
         DrawingPoints nextPoint= pointsList[i + 1];


         endPoint = currentPoint;

         if(currentPoint.type == PointType.Start) {
           startPoint = currentPoint;

         }

         if(pathPoints!=[] ){
          // pathPoints.map((e) => canvas.drawPoints(PointMode.points, [e.points], e.paint..style = PaintingStyle.stroke));
         for(int i =0; i < pathPoints.length -1; i++){
           canvas.drawPoints(PointMode.points, pathPoints.map((e) => e.points).toList(),
               pathPoints[i].paint
                 ..style = PaintingStyle.stroke
               //..strokeWidth=4
           );

         }
         }
         if (linePoints!=[]) {

        for(int i =0; i < linePoints.length -1; i++){
          canvas.drawPoints(PointMode.points, linePoints.map((e) => e.points).toList(), linePoints[i].paint..style = PaintingStyle.stroke
           // ..strokeWidth=4
          );

        }
      }

      if(currentPoint.drawingOption == Option.CIRCLE){
           drawFigure(canvas, currentPoint.paint, startPoint.points, currentPoint.points);
         }else if(currentPoint.drawingOption == Option.SQUARE){
           drawFigure(canvas, currentPoint.paint, startPoint.points, currentPoint.points,option: Option.SQUARE);
         }else if(currentPoint.drawingOption == Option.OVAL){
           drawFigure(canvas, currentPoint.paint, startPoint.points, currentPoint.points,option: Option.OVAL);
         }else if(currentPoint.drawingOption == Option.RECTANGLE){
           drawFigure(canvas, currentPoint.paint, startPoint.points, currentPoint.points,option: Option.RECTANGLE);
         }else if(currentPoint.type != PointType.End && nextPoint.type != PointType.End  &&currentPoint.drawingOption == Option.RUBBER){
           canvas.drawLine(currentPoint.points, nextPoint.points, currentPoint.paint..color = Colors.grey[50]);
         }else if(currentPoint.drawingOption == Option.PENCIL){
           for(int i = 0; i < linePoints.length -1 ;i++){

               if(linePoints[i].nth==1){
                 drawFigure(canvas, linePoints[i].paint..style =PaintingStyle.stroke, linePoints[i].points, linePoints[i + 1].points,option: Option.PENCIL);}

         }}

        else if (currentPoint.type != PointType.End && nextPoint.type != PointType.End  && currentPoint.drawingOption == Option.HAND) {
          canvas.drawLine(currentPoint.points, nextPoint.points, currentPoint.paint);
        }else if(currentPoint.drawingOption == Option.PATH){

             for(int i = 0; i < pathPoints.length -1 ;i++){
               try{
               if(pathPoints[i].nth==1){
               drawFigure(canvas, currentPoint.paint..style= PaintingStyle.stroke,
                 pathPoints[i].points,
                 pathPoints[i + 2].points,
                 option: Option.PATH,
                 controlPoint: pathPoints[i+1].points
               );}
               }catch(e){


               }
             }

         }

        // else if (currentPoint.type != PointType.End  && nextPoint.type == PointType.End  && currentPoint.drawingOption == Option.HAND) {
        //   offsetPoints.clear();
        //   offsetPoints.add(currentPoint.points);
        //   offsetPoints.add(Offset(
        //       currentPoint.points.dx + 0.1, currentPoint.points.dy + 0.1));
        //   canvas.drawPoints(
        //       PointMode.points, offsetPoints, currentPoint.paint);
        // }

      }


  }
  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}