import 'package:flutter/painting.dart';

import 'options.dart';
enum PointType{
  Start,Intermediate,End
}
class DrawingPoints {
  final Option drawingOption;
  final Paint paint;
  final Offset points;
  final int nth;
  PointType type;
  DrawingPoints({this.points, this.paint,this.drawingOption,this.type =PointType.Intermediate,this.nth});
}