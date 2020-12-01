import 'package:drawing_app/hand_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'options.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Drawing App',
      theme: ThemeData(

        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Drawing App'),
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
  int _counter = 0;

  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.amber,
    Colors.black
  ];




  Option current_selected = Option.HAND;
  void changing_option(Option option){

    setState(() {
      current_selected = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    void changeColor(Color color) {
      setState(() => pickerColor = color);
    }


    return Scaffold(
      appBar: AppBar(

        title: Center(child: Text(widget.title)),
      ),
      body: Center(

        child: Stack(


          children: <Widget>[
            Text(''),
            Text(''),
            HandDrawer( selectedColor: selectedColor,pickedColor:pickerColor),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              onPressed: ()=>changing_option(Option.PENCIL),
              tooltip: 'Increment',
              child: Icon(FontAwesome.pencil),
            ),
            FloatingActionButton(
              onPressed: ()=>changing_option(Option.HAND),
              tooltip: 'Increment',
              child: Icon(FontAwesome.hand_pointer_o),
            ),FloatingActionButton(
              onPressed: (){
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
              tooltip: 'Increment',
              child: Icon(FontAwesome.dashboard,),

            ),

            FloatingActionButton(
              onPressed: ()=>changing_option(Option.SQUARE),
              tooltip: 'Increment',
              child: Icon(FontAwesome.square_o),
            ),FloatingActionButton(
              onPressed: ()=>changing_option(Option.PLUS),
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
