import 'dart:io';
import 'package:drawing_app/model.dart';
import 'package:drawing_app/starting_page/starting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:screenshot/screenshot.dart';
import 'package:toast/toast.dart';
import 'controller.dart';
import 'created_classes/options.dart';
import 'created_widgets/save_button.dart';
import 'home_page/my_drawer.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    return ScopedModel<MyModel>(
      model: MyModel(),
      child: MaterialApp(
        routes: {
          'startPage':(_)=>StartingPage(),
          'homePage':(_)=>MyHomePage(title: 'Painter',),
          'crossFade':(_)=>ControllerPage()
        },
        initialRoute: 'crossFade',
        title: 'Drawing App',
        theme: ThemeData(

          primarySwatch: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
       // home: MyHomePage(title: 'Painter'),
       // home: StartingPage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color selectedColor = Colors.amberAccent;
  Color pickerColor = Colors.amberAccent;

  File _imageFile;
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.amber,
    Colors.black
  ];

  Option optionSelected = Option.HAND;
  Color previousColor ;
  void changingOption(Option option){

    setState(() {
      optionSelected = option;
    });
  }
  double stokeWidth = 5;
  ScreenshotController screenshotController;
  @override
  void initState() {
    super.initState();
    screenshotController = ScreenshotController();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void changeColor(Color color) {
      setState(() => pickerColor = color);
    }




    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Scaffold(

        appBar: AppBar(

          title: Center(child: Text(widget.title)),
        ),
        body: Stack(
          children: <Widget>[

            buildMyDrawer(),
            buildSlider(),
            buildGuides()

          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              buildLineButton(context),
              buildHandButton(context),
              buildColorButton(context, changeColor),
              buildSaveButton(),


              FloatingActionButton(
                onPressed: (){
                  showDialog(
                      context: context,
                    child: AlertDialog(
                      content: Wrap(
                        spacing: 2,
                        children: [
                          buildRubberButton(context),
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
                    )

                  );
                },
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
            ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  SaveButton buildSaveButton() => SaveButton(changingOption: changingOption, screenshotController: screenshotController, optionSelected: optionSelected,);

  FlatButton buildDoneButton(BuildContext context) {
    return FlatButton(
                        child: const Text('Done'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      );
  }

  FloatingActionButton buildPathButton(BuildContext context) {
    return FloatingActionButton(
                          onPressed: () {
                            changingOption(Option.PATH);
                            showToast('Path', context);
                          },
                          child: Icon(FontAwesome.circle_o_notch),
                        );
  }

  FloatingActionButton buildTriangleButton(BuildContext context) {
    return FloatingActionButton(
                          onPressed: () {
                            changingOption(Option.TRIANGLE);
                            showToast('Triangle', context);
                          },
                          child: Icon(FontAwesome.exclamation_triangle),
                        );
  }

  FloatingActionButton buildOvalButton(BuildContext context) {
    return FloatingActionButton(
                          onPressed: () {
                            changingOption(Option.RECTANGLE);
                            showToast('Rectangle', context);
                          },
                          child: Icon(FontAwesome.times_rectangle),
                        );
  }

  FloatingActionButton buildCircleButton(BuildContext context) {
    return FloatingActionButton(
                          onPressed: () {
                            changingOption(Option.CIRCLE);
                            showToast('Circle', context);

                          },
                          child: Icon(FontAwesome.circle_o),
                        );
  }

  FloatingActionButton buildSquareButton() {
    return FloatingActionButton(

                          onPressed: ()=>changingOption(Option.SQUARE),

                          tooltip: 'square',
                          child: Icon(FontAwesome.square_o,),

                        );
  }

  FloatingActionButton buildRubberButton(BuildContext context) {
    return FloatingActionButton(
                          onPressed: (){

                            changingOption(Option.RUBBER);
                            showToast('Eraser', context);

                            },
                          child: Icon(FontAwesome.eraser,),


                          tooltip: 'Eraser',
                        );
  }

  FloatingActionButton buildColorButton(BuildContext context, void changeColor(Color color)) {
    return FloatingActionButton(
              onPressed: (){
                showToast('Pick a color', context,gravity: Toast.BOTTOM);
                showDialog(
                  context: context,
                  child: AlertDialog(
                    title: const Text('Pick a color!'),
                    content: SingleChildScrollView(
                      child: ColorPicker(
                        pickerColor: pickerColor,
                        onColorChanged: changeColor,
                        showLabel: true,
                        pickerAreaHeightPercent: 0.8,
                      ),

                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: const Text('Got it'),
                        onPressed: () {
                          setState(() => selectedColor = pickerColor);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
              tooltip: 'choose color',
              child: Icon(FontAwesome.dashboard,),

            );
  }

  FloatingActionButton buildHandButton(BuildContext context) {
    return FloatingActionButton(
              child: Icon(FontAwesome.hand_pointer_o,color: optionSelected==Option.HAND?Colors.green:Colors.white,),
              onPressed: (){
                if(optionSelected==Option.RUBBER){
                  selectedColor = previousColor ??Colors.yellow;
                }
                showToast('hand', context);

                changingOption(Option.HAND);},
              tooltip: 'Increment',
            );
  }

  FloatingActionButton buildLineButton(BuildContext context) {
    return FloatingActionButton(
              onPressed: (){
                changingOption(Option.PENCIL);
                showToast('Line', context);
                },

              tooltip: 'Increment',
              child: Icon(FontAwesome.pencil,color: optionSelected==Option.PENCIL?Colors.green:Colors.white,),
            );
  }

  Widget buildMyDrawer() {
    return MyDrawer( selectedColor: selectedColor,
            pickedColor:pickerColor,strokeWidth:stokeWidth,
            drawingOption: optionSelected,
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
                        return Switch.adaptive( value: model.guides, onChanged: model.changeGuides);
                      },
                    ),
                  ],
                ),
              ));
  }

  Widget buildSlider() {
    return Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100,right: 10,top: 10),
              child: RotatedBox(
                quarterTurns: -1,
                child: FluidSlider(
                  thumbDiameter: 35,
                  value: stokeWidth,
                  onChanged: (double newValue) {
                    setState(() {
                      stokeWidth = newValue;
                    });
                  },
                  min: 0.0,
                  max: 30.0,
                ),
              ),
            ),
          );
  }
}
void showToast(String msg, BuildContext context, {int duration, int gravity}) {
  Toast.show(msg, context, duration: duration, gravity: gravity);
}

