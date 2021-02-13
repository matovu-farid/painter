import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:scoped_model/scoped_model.dart';
import 'main.dart';
import 'package:toast/toast.dart';

import 'model.dart';

class ColorButton extends StatelessWidget {

  const ColorButton({
    Key key,

  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.amber,
      onPressed: () {
        showToast('Pick a color', context, gravity: Toast.BOTTOM);
        showColorPopUp(context);
      },
      tooltip: 'choose color',
      child: Icon(
        FontAwesome.forumbee
      ),
    );
  }

  Future showColorPopUp(BuildContext context) {
    return showDialog(
        context: context,
        child: AlertDialog(
          title: const Text('Pick a color!'),
          content: ScopedModelDescendant<MyModel>(
            builder: (context, child,model) {
              return buildColorPicker(model);
            }
          ),
          actions: <Widget>[
            GotItButton(),
          ],
        ),
      );
  }

  ColorPicker buildColorPicker(MyModel model) {
    return ColorPicker(
                  pickerColor: model.previousColor,
                  onColorChanged: model.changeColor,
                  showLabel: true,
                  pickerAreaHeightPercent: 0.8,
                );
  }
}

class GotItButton extends StatelessWidget {
  const GotItButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MyModel>(
      builder: (context, child, model) {
        return FlatButton(
          child: const Text('Got it'),
          onPressed: () {
            model.selectedColor = model.previousColor;
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
