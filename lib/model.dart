import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'created_classes/drawing_point_class.dart';
import 'created_classes/options.dart';

class MyModel extends Model with EquatableMixin{
  var message = '';

   Map<String,List<DrawingPoint>> optionMap={
    'pointList':[],
  'pathList':[],
    'lineList':[],
    'triangleList':[]
  };
   clear(){
     optionMap={
       'pointList':[],
       'pathList':[],
       'lineList':[],
       'triangleList':[]
     };
   }
   changeMessage(String message){
     this.message = message;
     notifyListeners();
   }
  //List<AnalyzedPoint> analyzedList = [];

   // StreamController<Map<String,List<DrawingPoint>>>  controller = StreamController.broadcast();
   //
   // addToSink(){
   //
   //   controller.sink.add(optionMap);
   //  // controller.sink.close();
   // }
   // Stream<Map<String,List<DrawingPoint>>> get stream=>controller.stream;
   // saveStream(){
   //   addToSink();
   //   stream.listen((map) {
   //     //print(map);
   //     listOfMaps.add(map);});
   //
   //   index++;
   //   print(index);
   //
   // }
  void addToMap(String listName,DrawingPoint point){
    // if(optionSelected!=Option.hand && point.drawingOption==Option.hand){
    //   return;
    // }
    //analyzedList.add(AnalyzedPoint(listName, point));
    optionMap[listName].add(point);
    //notifyListeners();
  }
  List<Map<String,List<DrawingPoint>>> listOfMaps = [];
  static int index = 0;
  // save(){
  //
  //   //listOfMaps[index]=optionMap;
  //   listOfMaps.add(optionMap);
  //   index++;
  //   print(listOfMaps);
  // }
  void undo(){
    index--;
    index = index<=0? 0:index;
    optionMap= listOfMaps[index];

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

  @override
  // TODO: implement props
  List<Object> get props => [strokeWidth,selectedColor,previousColor,iconColor,optionSelected,guides,previousOption,optionList,optionMap];

  changeGuides(bool guidesGot){
    guides = guidesGot;
    notifyListeners();
  }
  controlNth(){

    if(optionSelected==Option.path ||optionSelected==Option.triangle) {
      //print(nth);
      if (nth < 3)
        nth++;
      else
        nth = 1;
    }else if (optionSelected==Option.line){
      //print(nth);
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