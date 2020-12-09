import 'dart:io';

import 'package:drawing_app/options.dart';
import 'package:drawing_app/point_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:screenshot/screenshot.dart';

import 'drawing_points.dart';
import 'model.dart';

class MyDrawer extends StatefulWidget{
   Color selectedColor;
   Color pickedColor;
   final double strokeWidth;
   final Option drawingOption;
   final ScreenshotController screenshotController;
   MyDrawer({Key key, this.selectedColor, this.pickedColor, this.strokeWidth, @required this.drawingOption,this.screenshotController,}) : super(key: key);


  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  List<DrawingPoints> points = [];
  List<DrawingPoints> pathPoints = [];
  List<DrawingPoints> linePoints = [];
  List<DrawingPoints> trianglePoints = [];
  File _imageFile;



  double opacity = 1.0;
  StrokeCap strokeCap = (Platform.isAndroid) ? StrokeCap.butt : StrokeCap.round;
  int nth = 1;

  controlNth(int nth,Option option){
    if(option==Option.PATH ||option==Option.TRIANGLE) {
      print(nth);
      if (nth < 3)
        this.nth++;
      else
        this.nth = 1;
    }else if (option ==Option.PENCIL){
      print(nth);
      if (nth < 2)
        this.nth++;
      else
        this.nth = 1;
    }
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      child: Screenshot(
        controller: widget.screenshotController,
        child: Scaffold(


          body: ScopedModelDescendant<MyModel>(
           builder: (context,widget,model){
             return CustomPaint(


                 painter: DrawingPainter(model:model,pointsList: points,pathPoints: pathPoints,linePoints: linePoints,trianglePoints: trianglePoints),
                 size: Size.infinite);
           },

          ),
        ),
      ),

      onPanDown: (details){

        setState(() {
          if(widget.drawingOption == Option.PATH ){
            RenderBox renderBox = context.findRenderObject();
            pathPoints.add(DrawingPoints(
                nth: nth,
                drawingOption: widget.drawingOption,
                points: renderBox.globalToLocal(details.globalPosition),
                paint: Paint()
                  ..strokeCap = strokeCap
                  ..isAntiAlias = true
                  ..color = widget.selectedColor.withOpacity(opacity)
                  ..strokeWidth = widget.strokeWidth));
            controlNth(nth,widget.drawingOption);
          }else if(widget.drawingOption == Option.PENCIL ){
            RenderBox renderBox = context.findRenderObject();
            linePoints.add(DrawingPoints(
                nth: nth,
                drawingOption: widget.drawingOption,
                points: renderBox.globalToLocal(details.globalPosition),
                paint: Paint()
                  ..strokeCap = strokeCap
                  ..isAntiAlias = true
                  ..color = widget.selectedColor.withOpacity(opacity)
                  ..strokeWidth = widget.strokeWidth));
            controlNth(nth,widget.drawingOption);
          }else if(widget.drawingOption == Option.TRIANGLE ){
            RenderBox renderBox = context.findRenderObject();
            trianglePoints.add(DrawingPoints(
                nth: nth,
                drawingOption: widget.drawingOption,
                points: renderBox.globalToLocal(details.globalPosition),
                paint: Paint()
                  ..strokeCap = strokeCap
                  ..isAntiAlias = true
                  ..color = widget.selectedColor.withOpacity(opacity)
                  ..strokeWidth = widget.strokeWidth));
            controlNth(nth,widget.drawingOption);
          }
        });

      },

      onPanUpdate: (details) {
        setState(() {
          RenderBox renderBox = context.findRenderObject();
          points.add(DrawingPoints(
            drawingOption: widget.drawingOption,
              points: renderBox.globalToLocal(details.globalPosition),
              paint: Paint()
                ..strokeCap = strokeCap
                ..isAntiAlias = true
                ..color = widget.selectedColor.withOpacity(opacity)
                ..strokeWidth = widget.strokeWidth));
        });
      },
      onPanStart: (details) {
        setState(() {
          RenderBox renderBox = context.findRenderObject();
          points.add(DrawingPoints(
            type: PointType.Start,
            drawingOption: widget.drawingOption,
              points: renderBox.globalToLocal(details.globalPosition),
              paint: Paint()
                ..strokeCap = strokeCap
                ..isAntiAlias = true
                ..color = widget.selectedColor.withOpacity(opacity)
                ..strokeWidth = widget.strokeWidth));
        });
      },
      onPanEnd: (details) {
        setState(() {
          points.last.type=PointType.End;
        });
      },

    );
  }
}