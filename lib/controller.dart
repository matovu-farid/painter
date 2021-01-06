import 'dart:async';

import 'package:drawing_app/main.dart';
import 'package:drawing_app/starting_page/starting_page.dart';
import 'package:flutter/material.dart';
class ControllerPage extends StatefulWidget {

  @override
  _ControllerPageState createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  bool goToHome = false;

  timerCallback(){
    setState(() {
      goToHome = true;
      currentWidget = MyHomePage(title: 'Painter');
    });

  }

  CrossFadeState crossFadeState ;
  Widget currentWidget = StartingPage();

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3),timerCallback);
    return Scaffold(
      body: AnimatedSwitcher(duration: Duration(seconds: 2),
        transitionBuilder: (child,animation){
        return ScaleTransition(scale: animation,child: child,);
        },
        child: currentWidget,
      ),
    );

  }

}
