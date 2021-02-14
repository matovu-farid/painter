import 'package:drawing_app/created_classes/options.dart';
import 'package:drawing_app/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:scoped_model/scoped_model.dart';

import '../main.dart';
class OptionButton extends StatelessWidget {
  final Option optionSelected;
  final String toastMessage;
  final Widget icon;
  final Function onPressed;

  const OptionButton({Key key, this.onPressed,@required this.optionSelected,@required this.toastMessage,@required this.icon,}) : super(key: key);
  onOptionButtonPressed(MyModel model,BuildContext context){
    model.changeOption(optionSelected);
    showToast(toastMessage, context);
  }
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MyModel>(
      builder: (BuildContext context,Widget child,MyModel model){
        return FloatingActionButton(

          onPressed:onPressed!=null?
          (){
            model.changeOption(optionSelected);
            showToast(toastMessage, context);
            onPressed();
          }
              : ()=>onOptionButtonPressed(model, context),
          child: icon,
        );
      },


    );
  }
}
class HandButton extends OptionButton{
  final MyModel model;
  HandButton(Option optionSelected,String message,icon,this.model):super(optionSelected: optionSelected,toastMessage: message,icon: icon);
  @override
  onOptionButtonPressed(MyModel model, BuildContext context) {
    if(optionSelected==Option.rubber){
      model.changeColor(model.previousColor ?? Colors.yellow);
    }
    showToast('hand', context);
    model.changeOption(Option.hand);
    model.changeMessage('Shade');
  }

  }
