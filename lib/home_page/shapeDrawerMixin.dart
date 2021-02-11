import 'dart:io';

import 'package:drawing_app/created_classes/drawing_point_class.dart';
import 'package:drawing_app/created_classes/options.dart';

import '../model.dart';
import 'package:flutter/material.dart';

class ShapeDrawerMixin{

  File _imageFile;

  double opacity = 1.0;
  StrokeCap strokeCap = (Platform.isAndroid) ? StrokeCap.butt : StrokeCap.round;
  //int nth = 1;

  void onPanDown(details, MyModel model,RenderBox renderBox) {
    model.changeGuides(true);

    print(renderBox.globalToLocal(details.globalPosition));

      if (model.optionSelected == Option.PATH) {
        addFirstPointToPathContainer(model, renderBox, details);
      } else if (model.optionSelected == Option.PENCIL) {
        //RenderBox renderBox = context.findRenderObject();
        addFistPointToLineContainer(model, renderBox, details);
      } else if (model.optionSelected == Option.TRIANGLE) {
        //RenderBox renderBox = context.findRenderObject();
        addFirstPointToTraingleContainer(model, renderBox, details);
      }

  }

  void addFirstPointToTraingleContainer(
      MyModel model, RenderBox renderBox, details) {
    model.triangleList.add(DrawingPoints(
        nth: model.nth,
        drawingOption: model.optionSelected,
        points: renderBox.globalToLocal(details.globalPosition),
        paint: Paint()
          ..strokeCap = strokeCap
          ..isAntiAlias = true
          ..color = model.selectedColor.withOpacity(opacity)
          ..strokeWidth = model.strokeWidth));
    model.controlNth();
  }

  void addFistPointToLineContainer(
      MyModel model, RenderBox renderBox, details) {
    model.lineList.add(DrawingPoints(
        nth: model.nth,
        drawingOption: model.optionSelected,
        points: renderBox.globalToLocal(details.globalPosition),
        paint: Paint()
          ..strokeCap = strokeCap
          ..isAntiAlias = true
          ..color = model.selectedColor.withOpacity(opacity)
          ..strokeWidth = model.strokeWidth));
    model.controlNth();
  }

  void addFirstPointToPathContainer(
      MyModel model, RenderBox renderBox, details) {
    model.pathList.add(DrawingPoints(
        nth: model.nth,
        drawingOption: model.optionSelected,
        points: renderBox.globalToLocal(details.globalPosition),
        paint: Paint()
          ..strokeCap = strokeCap
          ..isAntiAlias = true
          ..color = model.selectedColor.withOpacity(opacity)
          ..strokeWidth = model.strokeWidth));
    model.controlNth();
  }

  void addStartPointToPointsContainer(
      BuildContext context,
      Option selectedOption,
      DragStartDetails details,
      Color selectedColor,
      MyModel model) {
    RenderBox renderBox = context.findRenderObject();
    model.pointsList.add(DrawingPoints(
        type: PointType.Start,
        drawingOption: selectedOption,
        points: renderBox.globalToLocal(details.globalPosition),
        paint: Paint()
          ..strokeCap = strokeCap
          ..isAntiAlias = true
          ..color = selectedColor.withOpacity(opacity)
          ..strokeWidth = model.strokeWidth));
  }

  void addTheNextPoints(BuildContext context, DragUpdateDetails details,
      Option selectedOption, Color selectedColor, MyModel model) {
    RenderBox renderBox = context.findRenderObject();
    var drawingPoints = renderBox.globalToLocal(details.globalPosition);
    print(drawingPoints);

      model.pointsList.add(DrawingPoints(
          drawingOption: selectedOption,
          points: drawingPoints,
          paint: Paint()
            ..strokeCap = strokeCap
            ..isAntiAlias = true
            ..color = selectedColor.withOpacity(opacity)
            ..strokeWidth = model.strokeWidth));

  }

}