// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:drawing_app/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:drawing_app/main.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  Widget myWidget = ScopedModel(
      model: MyModel(),
      child: MaterialApp(home: MyHomePage(title: 'DrawingApp',),));
  testWidgets('Taps Alert Dialog box', (WidgetTester tester) async {

    await tester.pumpWidget(myWidget);

   final morefinder = find.byTooltip('More');
   final alertBoxfinder = find.byType(AlertDialog);

   expect(morefinder,findsOneWidget);

   expect(find.byType(AlertDialog),findsNothing);

   await tester.tap(morefinder);

   await tester.pump();

   expect(alertBoxfinder, findsOneWidget);

  });
  testWidgets('test Line', (tester)async{
    await tester.runAsync(() async{
      await tester.pumpWidget(myWidget);
      Finder lineFinder = find.byKey(Key('Line'));
      Finder canvasFinder = find.byKey(Key('canvas'));
      expect(lineFinder,findsOneWidget);
      expect(canvasFinder,findsOneWidget);
      await tester.tap(lineFinder);
      await tester.pump();
    });


  });

}
