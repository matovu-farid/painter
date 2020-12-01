import 'dart:io';

import 'package:drawing_app/point_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'drawing_points.dart';

class HandDrawer extends StatefulWidget{
   Color selectedColor;
   Color pickedColor;

   HandDrawer({Key key, this.selectedColor, this.pickedColor}) : super(key: key);


  @override
  _HandDrawerState createState() => _HandDrawerState();
}

class _HandDrawerState extends State<HandDrawer> {
  List<DrawingPoints> points = [];

  double strokeWidth = 3.0;


  double opacity = 1.0;
  StrokeCap strokeCap = (Platform.isAndroid) ? StrokeCap.butt : StrokeCap.round;




  @override
  Widget build(BuildContext context) {



    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: GestureDetector(
        child: CustomPaint(
            painter: DrawingPainter(pointsList: points),
            size: Size.infinite),

        onPanUpdate: (details) {
          setState(() {
            RenderBox renderBox = context.findRenderObject();
            points.add(DrawingPoints(
                points: renderBox.globalToLocal(details.globalPosition),
                paint: Paint()
                  ..strokeCap = strokeCap
                  ..isAntiAlias = true
                  ..color = widget.selectedColor.withOpacity(opacity)
                  ..strokeWidth = 5));
          });
        },
        onPanStart: (details) {
          setState(() {
            RenderBox renderBox = context.findRenderObject();
            points.add(DrawingPoints(
                points: renderBox.globalToLocal(details.globalPosition),
                paint: Paint()
                  ..strokeCap = strokeCap
                  ..isAntiAlias = true
                  ..color = widget.selectedColor.withOpacity(opacity)
                  ..strokeWidth = 5));
          });
        },
        onPanEnd: (details) {
          setState(() {
            points.add(null);
          });
        },

      ),
    );
  }
}