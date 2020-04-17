import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_webant/resources/app_colors.dart';
import 'package:test_webant/services/auth.dart';
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

  double _fontSize = 18;


  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: AuthService().user,
      child: Scaffold(
          backgroundColor: AppColors.createPhotoScreenBackground,
          appBar: AddPhotoInformationAppBar(widget._imageSource, _name, _description, _tags,),
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
                  top: BorderSide(color: AppColors.formFieldColor),
                )),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 10, 16, 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.formFieldColor),
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
                    Tags(
                      key: _tagStateKey,
                      textField: TagsTextField(
                          textStyle: TextStyle(fontSize: 14),
                          onSubmitted: (String str) {
                            setState(() {
                              _tags.add(str);
                            });
                          }
                      ),
                      itemCount: _tags.length,
                      itemBuilder: (int index){
                        final item = _tags[index];
                        return ItemTags(
                          pressEnabled: false,
                          activeColor: AppColors.appBarButtonColor,
                          key: Key(index.toString()),
                          index: index, // required
                          title: item,
                          textStyle: TextStyle( fontSize: _fontSize, ),
                          combine: ItemTagsCombine.withTextBefore,
                          removeButton: ItemTagsRemoveButton(
                            onRemoved: (){
                              setState(() {
                                _tags.removeAt(index);
                              });
                              return true;
                            },
                          ), // OR null,
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
}
