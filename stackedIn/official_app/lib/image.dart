import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  File image;
  Future getImage() async {
    File picture = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      image = picture;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stacked Point: ")),
      body:Center(
      child: image==null
        ? Text('Smash the Camera Button to Take a Picture')
      :Image.file(image),
      ),
      drawer: Text("a drawer"),
      floatingActionButton: FloatingActionButton(
        tooltip: "button",
        child: Icon(Icons.add_a_photo),
        onPressed: getImage,
      ),
    );
  }
}
