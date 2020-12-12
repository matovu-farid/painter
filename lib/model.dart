import 'package:scoped_model/scoped_model.dart';

class MyModel extends Model{
  bool guides = false;
  changeGuides(bool guidesGot){
    guides = guidesGot;
    notifyListeners();
  }
}