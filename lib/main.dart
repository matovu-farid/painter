import 'dart:io';
import 'package:drawing_app/dot_slider.dart';
import 'package:drawing_app/color_button.dart';
import 'package:drawing_app/created_widgets/option_button.dart';
import 'package:drawing_app/main_methods.dart';
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
import 'created_widgets/more_button.dart';
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
          'startPage': (_) => StartingPage(),
          'homePage': (_) => MyHomePage(
                title: 'Painter',
              ),
          'crossFade': (_) => ControllerPage()
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

class _MyHomePageState extends State<MyHomePage> with MainMethods{

  Option optionSelected = Option.HAND;

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
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text(widget.title)),
          actions: [IconButton(icon: Icon(FontAwesome.undo), onPressed: null)],
        ),
        body: Stack(
          children: <Widget>[
            buildMyDrawer(),
            buildSlider(),
          ],
        ),
        floatingActionButton: buildRowOfOptions(
            context), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Padding buildRowOfOptions(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 8),
      child: ScopedModelDescendant<MyModel>(
          builder: (BuildContext context, child, model) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildLineButton(model),
            buildHandButton(model),
            buildColorButton(),
            buildSaveButton(model),
            buildMoreButton(),
          ],
        );
      }),
    );
  }


}

void showToast(String msg, BuildContext context, {int duration, int gravity}) {
  Toast.show(msg, context, duration: duration, gravity: gravity);
}
