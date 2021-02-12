import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'created_classes/drawing_point_class.dart';
import 'created_classes/options.dart';

class MyModel extends Model{

  final Map<String,List<DrawingPoint>> optionMap={
    'pointList':[],
  'pathList':[],
    'lineList':[],
    'triangleList':[]
  };
  List<AnalyzedPoint> analyzedList = [];
  void addToMap(String listName,DrawingPoint point){
    analyzedList.add(AnalyzedPoint(listName, point));
    optionMap[listName].add(point);
  }

  double strokeWidth = 5;
  int nth = 1;
  Color selectedColor = Colors.amberAccent;
  Color previousColor = Colors.amberAccent;
  Color iconColor = Colors.lightGreen;
  Option optionSelected = Option.hand;
  bool guides = false;
  Option previousOption;
  final optionList = [Option.hand,Option.line,];
  undo(){
    final last = analyzedList.last;
    final secondLast = analyzedList[analyzedList.length-2];

    if(last.point.type==Option.line){

    }
  }
  changeGuides(bool guidesGot){
    guides = guidesGot;
    notifyListeners();
  }
  controlNth(){

    if(optionSelected==Option.path ||optionSelected==Option.triangle) {
      print(nth);
      if (nth < 3)
        nth++;
      else
        nth = 1;
    }else if (optionSelected==Option.line){
      print(nth);
      if (nth < 2)
        nth++;
      else
        nth = 1;
    }
    notifyListeners();
  }


  void changeOption(Option option){
    previousOption = optionSelected;
      optionSelected = option;
      if(option!=Option.save)optionList.add(option);
      notifyListeners();
  }
  void changeStrokeWidth(double strokeWidth){
    this.strokeWidth = strokeWidth;
    notifyListeners();
  }
  void changeColor(Color color){
    previousColor = selectedColor;
    selectedColor = color;
    notifyListeners();
  }
}
class  AnalyzedPoint{
  final String listName;
  final DrawingPoint point;

  AnalyzedPoint(this.listName, this.point);
}