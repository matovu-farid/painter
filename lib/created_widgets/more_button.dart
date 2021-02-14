import 'package:drawing_app/created_classes/options.dart';
import 'package:drawing_app/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:scoped_model/scoped_model.dart';
import 'option_button.dart';
class MoreButton extends StatelessWidget{
  Widget buildPathButton(MyModel model) {
    return PathButton(model: model,);
  }

  Widget buildTriangleButton(MyModel model) {
    return TriangleButton(model: model,);
  }

  Widget buildOvalButton() {
    return OvalButton();
  }

  Widget buildCircleButton() {
    return CircleButton();
  }

  Widget buildSquareButton() {
    return SquareButton();
  }

  Widget buildRubberButton(MyModel model) {
    
    return RubberButton(model:model);
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
            child: ScopedModelDescendant<MyModel>(

              builder: (context, child,model) {
                return AlertDialog(
                  key: Key('AlertBox'),
                  content: Wrap(
                    spacing: 2,
                    children: [
                      buildRubberButton(model),
                      buildSquareButton(),
                      buildCircleButton(),
                      buildOvalButton(),
                      buildTriangleButton(model),
                      buildPathButton(model),
                    ],
                  ),
                  actions: [
                    buildDoneButton(context),
                  ],
                );
              }
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
  final MyModel model;
 RubberButton({
    Key key,
   this.model

  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return OptionButton(
      onPressed: (){
        model.changeMessage('Rub');
      },
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
      icon: ImageIcon(
        AssetImage('assets/project_icons/Rectangle_svg.png')
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
        icon: Icon(FontAwesome.circle));
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
        icon: ImageIcon(
          AssetImage('assets/project_icons/oval.png')
        )
    );
  }
}

class TriangleButton extends StatelessWidget {
  final MyModel model;
  const TriangleButton({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OptionButton(
      onPressed: (){
        model.changeMessage('Tap Point 1');
      },
        optionSelected: Option.triangle,
        toastMessage: 'Triangle',
        icon: ImageIcon(AssetImage('assets/project_icons/triangle.png'))
    );
  }
}

class PathButton extends StatelessWidget {
  final MyModel model;
  const PathButton({
    @required this.model,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OptionButton(
      onPressed: (){
        model.changeMessage('Tap Point 1');
      },
        optionSelected: Option.path,
        toastMessage: 'Path',
        icon: Icon(FontAwesome.stumbleupon_circle,size: 55,)
    );
  }
}