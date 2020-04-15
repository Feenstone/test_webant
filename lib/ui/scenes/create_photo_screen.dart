import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_webant/resources/app_colors.dart';
import 'package:test_webant/resources/app_strings.dart';
import 'package:test_webant/ui/custom_widgets/custom_app_bar.dart';

class CreatePhotoScreen extends StatefulWidget {
  @override
  _CreatePhotoScreenState createState() => _CreatePhotoScreenState();
}

class _CreatePhotoScreenState extends State<CreatePhotoScreen> {

  File _imageSource;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.createPhotoScreenBackground,
      appBar: CreatePhotoAppBar(_imageSource),
      body: ListView(
        children: <Widget>[
          Center(
            child: _imageSource == null ? Image.asset(AppStrings().webAntLogoAssetRoot) : Image.file(_imageSource),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 36,
              margin: EdgeInsets.fromLTRB(16, 40, 16, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.black)
              ),
              child: RaisedButton(
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                color: Colors.white,
                onPressed: () => _pickImage(ImageSource.gallery),
                child: Text(
                  'Select Photo',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
    ],
      ),
    );
  }
  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageSource = selected;
    });
  }
}
