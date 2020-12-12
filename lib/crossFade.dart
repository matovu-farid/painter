import 'dart:async';

import 'package:drawing_app/main.dart';
import 'package:drawing_app/starting_page.dart';
import 'package:flutter/material.dart';
class MyCrossFade extends StatefulWidget {

  @override
  _MyCrossFadeState createState() => _MyCrossFadeState();
}

class _MyCrossFadeState extends State<MyCrossFade> {
  bool goToHome = false;

  timerCallback(){
    setState(() {
      goToHome = true;
    });

  }

  CrossFadeState crossFadeState ;

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2),timerCallback);
    return Scaffold(
      body: AnimatedCrossFade(
        duration: Duration(milliseconds: 100),
        firstChild: StartingPage(),
        secondChild: MyHomePage(title: 'Painter'),
        crossFadeState:  goToHome ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      ),
    );
  }
}
