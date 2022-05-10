import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

class EditProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new GalleryAccessState();
  }
}

class GalleryAccessState extends State<EditProfileScreen> {
  File galleryFile;

  Future imageSelectorGallery() async {
    try {
      final galleryFile = (await ImagePicker().pickImage(
        source: ImageSource.gallery,
        // maxHeight: 50.0,
        // maxWidth: 50.0,
      ));
      if (galleryFile == null) return;

      final imageTemporary = File(galleryFile.path);
      setState(() {
        this.galleryFile = imageTemporary;
      });
    }on PlatformException catch (e){
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    //display image selected from gallery
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Gallery Access'),
        backgroundColor: Colors.green,
        actions: <Widget>[
          galleryFile != null ? Image.file(galleryFile, width: 160,height:160,fit: BoxFit.cover,):
          Text(
            "GFG",
            textScaleFactor: 3,
          )
        ],
      ),
      body: new Builder(
        builder: (BuildContext context) {
          return Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new RaisedButton(
                  child: new Text('Select Image from Gallery'),
                  onPressed: imageSelectorGallery,
                ),
                SizedBox(
                  height: 200.0,
                  width: 300.0,
                  child: galleryFile == null
                      ? Center(child: new Text('Sorry nothing selected!!'))
                      : Center(child: new Image.file(galleryFile)),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
