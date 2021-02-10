import 'package:drawing_app/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:scoped_model/scoped_model.dart';

class DotSlider extends StatelessWidget {
  const DotSlider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100, right: 10, top: 10),
        child: RotatedBox(
          quarterTurns: -1,
          child:
              ScopedModelDescendant<MyModel>(builder: (context, child, model) {
            return FluidSlider(
              thumbDiameter: 40,
              value: model.strokeWidth,
              onChanged: (double strokeWidth) {
                model.changeStrokeWidth(strokeWidth);
              },
              min: 0.0,
              max: 30.0,
            );
          }),
        ),
      ),
    );
  }
}
