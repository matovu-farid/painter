
import 'dart:ui';
import 'package:drawing_app/created_classes/drawing_point_class.dart';
import 'package:drawing_app/created_classes/options.dart';
import 'package:drawing_app/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class DrawingPainter extends CustomPainter {
  final MyModel model;
  DrawingPainter( {this.model,});
  List<DrawingPoint> get pointsList=>model.optionMap['pointList'];
  List<DrawingPoint> get pathList=>model.optionMap['pathList'];
  List<DrawingPoint> get lineList=>model.optionMap['lineList'];
  List<DrawingPoint> get triangleList=>model.optionMap['triangleList'];
  List<Offset> offsetPoints = List();

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

  DrawingPoint startPoint ;
  DrawingPoint endPoint ;

  DrawingPoint startCurvePoint ;
  DrawingPoint endCurvePoint ;
  DrawingPoint controlCurvePoint ;


  @override
  void paint(Canvas canvas, Size size) {
      for (int i = 0; i < pointsList.length - 1; i++) {
         DrawingPoint currentPoint= pointsList[i];
         DrawingPoint nextPoint= pointsList[i + 1];


         endPoint = currentPoint;

         if(currentPoint.type == PointType.Start) {
           startPoint = currentPoint;

         }
         if(model.guides) {
           if (pathList != []) {
             for (int i = 0; i < pathList.length - 1; i++) {
               canvas.drawPoints(
                   PointMode.points, pathList.map((e) => e.points).toList(),
                   pathList[i].paint
                     ..style = PaintingStyle.stroke
               );
             }
           }
           if (triangleList != []) {
             drawTriangleGuidePoints(canvas);
           }
           if (lineList != []) {
             drawLineGuidePoints(canvas);
           }
         }

      if(currentPoint.drawingOption == Option.circle){
           drawFigure(canvas, currentPoint.paint, startPoint.points, currentPoint.points);
         }else if(currentPoint.drawingOption == Option.square){
           drawFigure(canvas, currentPoint.paint, startPoint.points, currentPoint.points,option: Option.square);
         }else if(currentPoint.drawingOption == Option.oval){
           drawFigure(canvas, currentPoint.paint, startPoint.points, currentPoint.points,option: Option.oval);
         }else if(currentPoint.drawingOption == Option.rectangle){
           drawFigure(canvas, currentPoint.paint, startPoint.points, currentPoint.points,option: Option.rectangle);
         }else if(currentPoint.type != PointType.End && nextPoint.type != PointType.End  &&currentPoint.drawingOption == Option.rubber){
           canvas.drawLine(currentPoint.points, nextPoint.points, currentPoint.paint..color = Colors.grey[50]);
         }else if(currentPoint.drawingOption == Option.line){
           for(int i = 0; i < lineList.length -1 ;i++){

               if(lineList[i].nth==1){
                 drawFigure(canvas, lineList[i].paint..style =PaintingStyle.stroke, lineList[i].points, lineList[i + 1].points,option: Option.line,model: model);}

         }}

        else if (currentPoint.type != PointType.End && nextPoint.type != PointType.End  && currentPoint.drawingOption == Option.hand) {
          canvas.drawLine(currentPoint.points, nextPoint.points, currentPoint.paint);
        }else if(currentPoint.drawingOption == Option.path){

             for(int i = 0; i < pathList.length -1 ;i++){
               try{
               if(pathList[i].nth==1){
               drawFigure(canvas, pathList[i].paint..style= PaintingStyle.stroke,
                 pathList[i].points,
                 pathList[i + 2].points,
                 option: Option.path,
                 controlPoint: pathList[i+1].points,
                 model: model
               );}
               }catch(e){


               }
             }

         }else if(currentPoint.drawingOption == Option.triangle){

        for(int i = 0; i < triangleList.length -1 ;i++){
          try{
            if(triangleList[i].nth==1){
              drawFigure(canvas, triangleList[i].paint..style= PaintingStyle.stroke,
                  triangleList[i].points,
                  triangleList[i + 2].points,
                  option: Option.triangle,
                  model:model,
                  controlPoint: triangleList[i+1].points
              );}
          }catch(e){


          }
        }

      }


      }
      canvas.save();
      canvas.restore();


  }


  void drawLineGuidePoints(Canvas canvas) {
     for (int i = 0; i < lineList.length - 1; i++) {
      canvas.drawPoints(
          PointMode.points, lineList.map((e) => e.points).toList(),
          lineList[i].paint..style = PaintingStyle.stroke
        // ..strokeWidth=4
      );
    }
  }

  void drawTriangleGuidePoints(Canvas canvas) {
    for (int i = 0; i < triangleList.length - 1; i++) {
      canvas.drawPoints(
          PointMode.points, triangleList.map((e) => e.points).toList(),
          triangleList[i].paint
            ..style = PaintingStyle.stroke

        //..strokeWidth=4
      );
    }
  }
  @override
  bool shouldRepaint(DrawingPainter oldDelegate) =>true;
}