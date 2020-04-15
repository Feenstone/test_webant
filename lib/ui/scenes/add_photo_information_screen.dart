import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test_webant/resources/app_colors.dart';
import 'package:test_webant/ui/custom_widgets/custom_app_bar.dart';
import 'package:flutter_tags/flutter_tags.dart';

class AddPhotoInformationScreen extends StatefulWidget {
  final File _imageSource;

  AddPhotoInformationScreen(this._imageSource);

  @override
  _AddPhotoInformationScreenState createState() =>
      _AddPhotoInformationScreenState();
}

class _AddPhotoInformationScreenState extends State<AddPhotoInformationScreen> {

  List _tags = [];

  String _name;
  String _description;

  double _fontSize = 12;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.createPhotoScreenBackground,
        appBar: AddPhotoInformationAppBar(widget._imageSource, _name, _description),
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: 62,
            ),
            Image.file(widget._imageSource),
            SizedBox(
              height: 63,
            ),
            Container(
              height: 350,
              decoration: BoxDecoration(color: Colors.white,
              border: Border(
                top: BorderSide(color: Color(0xFFC4C4C4)),
              )),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(16, 10, 16, 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFC4C4C4)),
                      borderRadius: BorderRadius.circular(4)
                    ),
                    height: 36,
                    child: TextFormField(
                        textInputAction: TextInputAction.next,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: TextStyle(
                              color: AppColors.formFieldColor, fontSize: 17),
                          border: InputBorder.none,
                        ),
                      onChanged: (val) {
                          setState(() {
                            _name = val;
                          });
                      },
                      validator: (val) =>
                      val.isEmpty ? 'Add name to your image' : null,
                    ),
                  ),
                  Container(
                    height: 100,
                    margin: EdgeInsets.fromLTRB(16, 0, 16, 25),
                    decoration: BoxDecoration(color: Colors.white,
                        border: Border.all(color: Color(0xFFC4C4C4)),
                        borderRadius: BorderRadius.circular(4)),
                    child: TextFormField(
                        textInputAction: TextInputAction.next,
                        style: TextStyle(color: Colors.black),
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Description",
                          hintStyle: TextStyle(
                              color: AppColors.formFieldColor, fontSize: 17),
                          border: InputBorder.none,
                        ),
                      onChanged: (val) {
                        setState(() {
                          _description = val;
                        });
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
