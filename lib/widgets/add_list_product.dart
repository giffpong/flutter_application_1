import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddListProduct extends StatefulWidget {
  @override
  _AddListProductState createState() => _AddListProductState();
}

class _AddListProductState extends State<AddListProduct> {
  // Field
  File file;
  String name, detail;

  // Method
  Widget uploadButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: RaisedButton.icon(
            color: Colors.red,
            onPressed: () {
              if (file == null) {
                showAlert('No Picture for Upload',
                    'Please Click Camera or Gallery icon');
              }
            },
            icon: Icon(
              Icons.cloud_upload,
              color: Colors.white,
            ),
            label: Text(
              'Upload Data to Database',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> showAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: ListTile(
            leading: Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 48.0,
            ),
            title: Text(
              title,
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Text(message),
          actions: [
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'))
          ],
        );
      },
    );
    ;
  }

  Widget nameForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: TextField(
        onChanged: (String value) {
          name = value.trim();
        },
        decoration: InputDecoration(
          helperText: 'Type You Name of Product',
          labelText: 'Product Name',
          icon: Icon(Icons.badge),
        ),
      ),
    );
  }

  Widget detailForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: TextField(
        onChanged: (String value) {
          detail = value.trim();
        },
        decoration: InputDecoration(
          helperText: 'Type You Detail of Product',
          labelText: 'Product Detail',
          icon: Icon(Icons.details),
        ),
      ),
    );
  }

  Widget cameraButtton() {
    return IconButton(
      icon: Icon(
        Icons.add_a_photo,
        size: 36.0,
      ),
      color: Colors.orange.shade300,
      onPressed: () {
        chooseImage(ImageSource.camera);
      },
    );
  }

  Future<void> chooseImage(ImageSource imageSource) async {
    try {
      var object = await ImagePicker().getImage(
        source: imageSource,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );

      setState(() {
        file = File(object.path);
      });
    } catch (e) {}
  }

  Widget galleryButtton() {
    return IconButton(
      icon: Icon(
        Icons.add_photo_alternate,
        size: 36.0,
      ),
      color: Colors.green.shade300,
      onPressed: () {
        chooseImage(ImageSource.gallery);
      },
    );
  }

  Widget showButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        cameraButtton(),
        galleryButtton(),
      ],
    );
  }

  Widget showImage() {
    return Container(
      padding: EdgeInsets.all(30.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: file == null
          ? Image.asset('images/upload-image-logo.png')
          : Image.file(file),
    );
  }

  Widget showContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          showImage(),
          showButton(),
          SizedBox(
            height: 20.0,
          ),
          nameForm(),
          detailForm(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          showContent(),
          uploadButton(),
        ],
      ),
    );
  }
}
