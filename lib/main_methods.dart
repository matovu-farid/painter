import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:screenshot/screenshot.dart';

import 'color_button.dart';
import 'created_classes/options.dart';
import 'created_widgets/more_button.dart';
import 'created_widgets/option_button.dart';
import 'created_widgets/save_button.dart';
import 'dot_slider.dart';
import 'home_page/my_drawer.dart';
import 'model.dart';
class MainMethods{
  Widget buildMoreButton() {
    return MoreButton();
  }
  // void changingOption(Option option) {
  //   setState(() {
  //     optionSelected = option;
  //   });
  // }

  ScreenshotController screenshotController =  ScreenshotController();

  SaveButton buildSaveButton(MyModel model) => SaveButton(
    model: model,
    screenshotController: screenshotController,

  );

  Widget buildColorButton() {
    return ColorButton();
  }

  Widget buildHandButton(MyModel model) {
    final option = Option.HAND;
    return HandButton(
        option,
        'Hand',
        Icon(
          FontAwesome.hand_pointer_o,
          color: color(model, option),
        ));
  }

  Widget buildLineButton(MyModel model) {
    final option = Option.PENCIL;
    return OptionButton(
        key: Key('Line'),
        optionSelected: option,
        toastMessage: 'Line',
        icon: Icon(
          FontAwesome.pencil,
          color: color(model, option),
        ));
  }

  Color color(MyModel model, Option option) =>
      model.optionSelected == option ? Colors.green : Colors.white;

  Widget buildMyDrawer() {
    return ShapeDrawer(
      screenshotController: screenshotController,
    );
  }

  Widget buildGuides() {
    return Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text('Guides'),
              ScopedModelDescendant<MyModel>(
                builder: (BuildContext context, Widget child, MyModel model) {
                  return Switch.adaptive(
                      value: model.guides, onChanged: model.changeGuides);
                },
              ),
            ],
          ),
        ));
  }

  Widget buildSlider() {
    return DotSlider();
  }
}