import 'package:flutter/painting.dart';

import 'options.dart';
enum PointType{
  Start,Intermediate,End
}
class DrawingPoint {
  final Option drawingOption;
  final Paint paint;
  final Offset points;
  final int nth;
  PointType type;
  DrawingPoint({this.points, this.paint,this.drawingOption,this.type =PointType.Intermediate,this.nth});
@override
  String toString() {
    return points.toString();
  }
}