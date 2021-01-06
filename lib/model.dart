import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'created_classes/options.dart';

class MyModel extends Model{
  Color selectedColor = Colors.amberAccent;
  Color previousColor = Colors.amberAccent;
  Option optionSelected = Option.HAND;
  bool guides = false;
  Option previousOption;
  changeGuides(bool guidesGot){
    guides = guidesGot;
    notifyListeners();
  }
  void changeOption(Option option){
    previousOption = optionSelected;
      optionSelected = option;
      notifyListeners();
  }
  void changeColor(Color color){
    previousColor = selectedColor;
    selectedColor = color;
    notifyListeners();
  }
}