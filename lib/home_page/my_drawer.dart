import 'dart:async';
import 'dart:io';
import 'package:drawing_app/created_classes/options.dart';
import 'package:drawing_app/home_page/drawing_painter.dart';
import 'package:drawing_app/home_page/shapeDrawerMixin.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:screenshot/screenshot.dart';
import '../created_classes/drawing_point_class.dart';
import '../model.dart';
import 'package:google_fonts/google_fonts.dart';

class ShapeDrawer extends StatefulWidget {
  final ScreenshotController screenshotController;

  ShapeDrawer({
    Key key,
    @required this.screenshotController,
  }) : super(key: key);

  @override
  _ShapeDrawerState createState() => _ShapeDrawerState();
}

class _ShapeDrawerState extends State<ShapeDrawer> with ShapeDrawerMixin {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MyModel>(
      builder: (BuildContext context, Widget child, MyModel model) {
        Color selectedColor = model.selectedColor;
        Option selectedOption = model.optionSelected;
        //model.saveStream();
        return Stack(
          children: [
            GestureDetector(
              key: Key('canvas'),
              child: Screenshot(
                controller: widget.screenshotController,
                child: Scaffold(
                  body: CustomPaint(
                      painter: DrawingPainter(
                        model: model,
                      ),
                      size: Size.infinite),
                ),
              ),
              onPanDown: (details) {
                RenderBox renderBox = context.findRenderObject();
                onPanDown(details, model, renderBox);
              },
              onPanUpdate: (details) {
                setState(() {
                  addTheNextPoints(
                      context, details, selectedOption, selectedColor, model);
                });
              },
              onPanStart: (details) {
                addStartPointToPointsContainer(
                    context, selectedOption, details, selectedColor, model);
              },
              onPanEnd: (details) {
                model.optionMap['pointList'].last.type = PointType.End;
              },
            ),
            Align(
                alignment: Alignment.topCenter,
                child: Text(
                  model.message,
                  style: GoogleFonts.damion(
                    textStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 40,
                        color: Colors.grey[800]),
                  ),
                ))
          ],
        );
      },
    );
  }
}
