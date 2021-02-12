import 'package:drawing_app/created_classes/options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'option_button.dart';
class MoreButton extends StatelessWidget{
  Widget buildPathButton(BuildContext context) {
    return PathButton();
  }

  Widget buildTriangleButton(BuildContext context) {
    return TriangleButton();
  }

  Widget buildOvalButton(BuildContext context) {
    return OvalButton();
  }

  Widget buildCircleButton(BuildContext context) {
    return CircleButton();
  }

  Widget buildSquareButton() {
    return SquareButton();
  }

  Widget buildRubberButton() {
    
    return RubberButton();
  }
  Widget buildDoneButton(BuildContext context) {
    return DoneButton();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FloatingActionButton(
      key: Key('More'),
      onPressed: () {
        showDialog(
            context: context,
            child: AlertDialog(
              key: Key('AlertBox'),
              content: Wrap(
                spacing: 2,
                children: [
                  buildRubberButton(),
                  buildSquareButton(),
                  buildCircleButton(context),
                  buildOvalButton(context),
                  buildTriangleButton(context),
                  buildPathButton(context),
                ],
              ),
              actions: [
                buildDoneButton(context),
              ],
            ));
      },
      tooltip: 'More',
      child: Icon(Icons.add),
    );
  }

}

class DoneButton extends StatelessWidget {
  const DoneButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: const Text('Done'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}

class RubberButton extends StatelessWidget {
  const RubberButton({
    Key key,

  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return OptionButton(
        optionSelected: Option.rubber,
        toastMessage: 'Eraser',
        icon: Icon(
          FontAwesome.eraser,

        ));
  }
}

class SquareButton extends StatelessWidget {
  const SquareButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OptionButton(
      optionSelected: Option.square,
      toastMessage: 'square',
      icon: Icon(
        FontAwesome.square_o,
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  const CircleButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OptionButton(
        optionSelected: Option.circle,
        toastMessage: 'Circle',
        icon: Icon(FontAwesome.circle_o));
  }
}

class OvalButton extends StatelessWidget {
  const OvalButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OptionButton(
        optionSelected: Option.oval,
        toastMessage: 'Oval',
        icon: Icon(FontAwesome.times_rectangle));
  }
}

class TriangleButton extends StatelessWidget {
  const TriangleButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OptionButton(
        optionSelected: Option.triangle,
        toastMessage: 'Triangle',
        icon: Icon(FontAwesome.exclamation_triangle));
  }
}

class PathButton extends StatelessWidget {
  const PathButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OptionButton(
        optionSelected: Option.path,
        toastMessage: 'Path',
        icon: Icon(FontAwesome.circle_o_notch));
  }
}