import 'dart:io';
import 'package:drawing_app/created_classes/options.dart';
import 'package:drawing_app/home_page/drawing_painter.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:screenshot/screenshot.dart';
import '../created_classes/drawing_point_class.dart';
import '../model.dart';

class ShapeDrawer extends StatefulWidget{




   final ScreenshotController screenshotController;
   ShapeDrawer({Key key,@required this.screenshotController,}) : super(key: key);


  @override
  _ShapeDrawerState createState() => _ShapeDrawerState();
}

class _ShapeDrawerState extends State<ShapeDrawer> {
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
 void onPanDown(details,MyModel model){
    model.changeGuides(true);
    RenderBox renderBox = context.findRenderObject();
    print(renderBox.globalToLocal(details.globalPosition));
    setState(() {
      if(model.optionSelected == Option.PATH ){
        pathPoints.add(DrawingPoints(
            nth: nth,
            drawingOption: model.optionSelected,
            points: renderBox.globalToLocal(details.globalPosition),
            paint: Paint()
              ..strokeCap = strokeCap
              ..isAntiAlias = true
              ..color = model.selectedColor.withOpacity(opacity)
              ..strokeWidth = model.strokeWidth));
        controlNth(nth,model.optionSelected);
      }else if(model.optionSelected == Option.PENCIL ){
        RenderBox renderBox = context.findRenderObject();
        linePoints.add(DrawingPoints(
            nth: nth,
            drawingOption: model.optionSelected,
            points: renderBox.globalToLocal(details.globalPosition),
            paint: Paint()
              ..strokeCap = strokeCap
              ..isAntiAlias = true
              ..color = model.selectedColor.withOpacity(opacity)
              ..strokeWidth = model.strokeWidth));
        controlNth(nth,model.optionSelected);
      }else if(model.optionSelected== Option.TRIANGLE ){
        RenderBox renderBox = context.findRenderObject();
        trianglePoints.add(DrawingPoints(
            nth: nth,
            drawingOption: model.optionSelected,
            points: renderBox.globalToLocal(details.globalPosition),
            paint: Paint()
              ..strokeCap = strokeCap
              ..isAntiAlias = true
              ..color = model.selectedColor.withOpacity(opacity)
              ..strokeWidth = model.strokeWidth));
        controlNth(nth,model.optionSelected);
      }
    });

  }

  @override
  Widget build(BuildContext context) {

    return ScopedModelDescendant<MyModel>(
      builder: (BuildContext context, Widget child, MyModel model) {
         Color selectedColor = model.selectedColor;
         Option selectedOption = model.optionSelected;
        return GestureDetector(
          key: Key('canvas'),
          child: Screenshot(
            controller: widget.screenshotController,
            child: Scaffold(
              body: CustomPaint(
                  painter: DrawingPainter(model:model,pointsList: points,pathPoints: pathPoints,linePoints: linePoints,trianglePoints: trianglePoints),
                  size: Size.infinite),
            ),
          ),

          onPanDown: (details){
            model.changeGuides(true);
            RenderBox renderBox = context.findRenderObject();
            print(renderBox.globalToLocal(details.globalPosition));
            setState(() {
              if(selectedOption == Option.PATH ){

                pathPoints.add(DrawingPoints(
                    nth: nth,
                    drawingOption: selectedOption,
                    points: renderBox.globalToLocal(details.globalPosition),
                    paint: Paint()
                      ..strokeCap = strokeCap
                      ..isAntiAlias = true
                      ..color = model.selectedColor.withOpacity(opacity)
                      ..strokeWidth = model.strokeWidth));
                controlNth(nth,selectedOption);
              }else if(selectedOption == Option.PENCIL ){
                RenderBox renderBox = context.findRenderObject();
                linePoints.add(DrawingPoints(
                    nth: nth,
                    drawingOption: selectedOption,
                    points: renderBox.globalToLocal(details.globalPosition),
                    paint: Paint()
                      ..strokeCap = strokeCap
                      ..isAntiAlias = true
                      ..color = model.selectedColor.withOpacity(opacity)
                      ..strokeWidth = model.strokeWidth));
                controlNth(nth,selectedOption);
              }else if(selectedOption== Option.TRIANGLE ){
                RenderBox renderBox = context.findRenderObject();
                trianglePoints.add(DrawingPoints(
                    nth: nth,
                    drawingOption: selectedOption,
                    points: renderBox.globalToLocal(details.globalPosition),
                    paint: Paint()
                      ..strokeCap = strokeCap
                      ..isAntiAlias = true
                      ..color = selectedColor.withOpacity(opacity)
                      ..strokeWidth = model.strokeWidth));
                controlNth(nth,selectedOption);
              }
            });

          },

          onPanUpdate: (details) {
            RenderBox renderBox = context.findRenderObject();
            var drawingPoints = renderBox.globalToLocal(details.globalPosition);
            print(drawingPoints);
            setState(() {
              points.add(DrawingPoints(
                  drawingOption: selectedOption,
                  points: drawingPoints,
                  paint: Paint()
                    ..strokeCap = strokeCap
                    ..isAntiAlias = true
                    ..color = selectedColor.withOpacity(opacity)
                    ..strokeWidth = model.strokeWidth));
            });
          },
          onPanStart: (details) {
            setState(() {
              RenderBox renderBox = context.findRenderObject();
              points.add(DrawingPoints(
                  type: PointType.Start,
                  drawingOption: selectedOption,
                  points: renderBox.globalToLocal(details.globalPosition),
                  paint: Paint()
                    ..strokeCap = strokeCap
                    ..isAntiAlias = true
                    ..color = selectedColor.withOpacity(opacity)
                    ..strokeWidth = model.strokeWidth));
            });
          },
          onPanEnd: (details) {
            setState(() {
              points.last.type=PointType.End;
            });
          },

        );
      },

    );
  }
}