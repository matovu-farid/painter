import 'dart:io';
import 'package:drawing_app/model.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:drawing_app/created_classes/options.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:toast/toast.dart';
class SaveButton extends StatefulWidget {
  //final Function changingOption;

  final ScreenshotController screenshotController;


  final MyModel model;

  const SaveButton({Key key,@required this.screenshotController, @required this.model}) : super(key: key);
  @override
  _SaveButtonState createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {

  File _imageFile;
  _SaveButtonState();


  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(

      onPressed: (){
        widget.model.changeOption(Option.save);

        _imageFile = null;
        widget.screenshotController
            .capture()
            .then((File image) async {
          setState(() {
            _imageFile = image;
          });

          if(await Permission.storage.request().isGranted){
            final result = await ImageGallerySaver.saveImage(image
                .readAsBytesSync());
            Toast.show('Image Saved to gallery', context,duration: 1);
          }
        }).catchError((onError) {
          print(onError);
        });
      },


      tooltip: 'save',
      child: Icon(FontAwesome.save,color: Colors.white,),

    );
  }


}


