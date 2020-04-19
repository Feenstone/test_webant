import 'dart:io';

import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_webant/resources/app_colors.dart';
import 'package:test_webant/services/database.dart';
import 'package:test_webant/ui/custom_widgets/custom_app_bar.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'dart:developer' as developer;

import 'package:test_webant/ui/custom_widgets/custom_text_fields.dart';

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

  DateTime _uploadDateTime;

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    return Scaffold(
        backgroundColor: AppColors.createPhotoScreenBackground,
        appBar:
            AddPhotoInformationAppBar(callback: () async => _uploadImage(user)),
        body: Form(
          key: _formkey,
          child: ListView(
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
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: AppColors.formFieldColor),
                    )),
                child: Column(
                  children: <Widget>[
                    ImageNameTextFormField(callback: (val) => _name = val,),
                    ImageDescriptionTextFormField(callback: (val) => _description = val,),
                    Tags(
                      key: _tagStateKey,
                      textField: TagsTextField(
                          textStyle: TextStyle(fontSize: 14),
                          onSubmitted: (String str) {
                            setState(() {
                              _tags.add(str);
                            });
                          }),
                      itemCount: _tags.length,
                      itemBuilder: (int index) {
                        final item = _tags[index];
                        return ItemTags(
                          pressEnabled: false,
                          activeColor: AppColors.appBarButtonColor,
                          key: Key(index.toString()),
                          index: index,
                          // required
                          title: item,
                          textStyle: TextStyle(
                            fontSize: _fontSize,
                          ),
                          combine: ItemTagsCombine.withTextBefore,
                          removeButton: ItemTagsRemoveButton(
                            onRemoved: () {
                              setState(() {
                                _tags.removeAt(index);
                              });
                              return true;
                            },
                          ), // OR null,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> _uploadImage(user) async {
    if (_formkey.currentState.validate()) {
      developer.log(user.toString());
      _uploadDateTime = DateTime.now();
      final StorageReference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child(basename(widget._imageSource.path));
      final StorageUploadTask task =
          firebaseStorageRef.putFile(widget._imageSource);
      String downloadUrl = await (await task.onComplete).ref.getDownloadURL();
      DatabaseService().createPhotoData(_name, _description, downloadUrl,
          DateFormat("dd-MM-yyyy").format(_uploadDateTime), _tags, user.email);
    }
  }

  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
}
