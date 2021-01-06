
import 'dart:ui';
import 'package:drawing_app/created_classes/drawing_point_class.dart';
import 'package:drawing_app/starting_page/start_page_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class StartingPage extends StatefulWidget {
  @override
  _StartingPageState createState() => _StartingPageState();
}


class _StartingPageState extends State<StartingPage> with SingleTickerProviderStateMixin {

   
  Paint paint = Paint()
    ..strokeCap = StrokeCap.butt
    ..isAntiAlias = true
    ..color = Colors.green
    ..strokeWidth = 5;
 int  index = 0;
  PointType typeGetter(){
    if(index==0){ index++;return PointType.Start;}
    else if (index==1){index++; return PointType.Intermediate;}
    else {index=0;return PointType.End;}
  }


  
  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: CustomPaint(
        size: Size.infinite,
        painter: StartPagePainter(), ),
    );
  }
}

