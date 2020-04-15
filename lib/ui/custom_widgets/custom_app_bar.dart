import 'dart:io';
import 'dart:ui';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:test_webant/resources/app_colors.dart';
import 'package:test_webant/services/auth.dart';
import 'package:test_webant/services/database.dart';
import 'package:test_webant/ui/scenes/add_photo_information_screen.dart';
import 'dart:developer' as developer;
import 'package:intl/intl.dart';

class GalleryAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double _prefferedHeigt = 140;
  var tabController;

  GalleryAppBar(this.tabController);

  @override
  _GalleryAppBarState createState() => _GalleryAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeigt);
}

class _GalleryAppBarState extends State<GalleryAppBar> {
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: widget._prefferedHeigt,
      child: Column(
        children: <Widget>[
          Flexible(
            child: Container(
              margin: EdgeInsets.fromLTRB(16, 42, 16, 10),
              height: 36,
              decoration: BoxDecoration(
                color: Color.fromRGBO(142, 142, 147, 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                textInputAction: TextInputAction.done,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(
                        color: AppColors.formFieldColor, fontSize: 17),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xFFDADADA),
                    ),
                    suffixIcon: Icon(
                      Icons.mic,
                      color: Color(0xFFDADADA),
                    )),
                validator: (val) =>
                    !val.contains('@') ? 'enter an email' : null,
                onChanged: (val) {
                  setState(() => _searchText = val);
                },
              ),
            ),
          ),
          TabBar(
            tabs: <Tab>[
              Tab(
                text: 'New',
              ),
              Tab(
                text: 'Popular',
              )
            ],
            labelColor: Colors.black,
            controller: widget.tabController,
            unselectedLabelStyle: TextStyle(color: AppColors.formFieldColor, fontSize: 17),
            labelStyle: TextStyle(fontSize: 17),
            indicatorColor: Color(0xFFCF497E),
          ),
        ],
      ),
    );
  }
}

class GallerySignInAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  final double _prefferedHeigt = 88;

  @override
  _GallerySignInAppBarState createState() => _GallerySignInAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeigt);
}

class _GallerySignInAppBarState extends State<GallerySignInAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            bottom: (BorderSide(
          color: Color(0xFFC4C4C4),
        ))),
        color: Colors.white,
      ),
      height: widget._prefferedHeigt,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
            height: 46,
            width: 80,
            color: Colors.white,
            child: RaisedButton(
              color: Colors.white,
              elevation: 0.0,
              child: Text(
                "Cancel",
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(
                    0xFF5F5F5F,
                  ),
                  fontSize: 15,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            )),
      ),
    );
  }
}

class CreatePhotoAppBar extends StatelessWidget implements PreferredSizeWidget {

  final double _prefferedHeigt = 88;

  final File _imageSource;
  CreatePhotoAppBar(this._imageSource);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            bottom: (BorderSide(
              color: Color(0xFFC4C4C4),
            ))),
        color: Colors.white,
      ),
      height: _prefferedHeigt,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container( 
            height: 46,
            width: 80,
            color: Colors.white,
            child: RaisedButton(
              color: Colors.white,
              elevation: 0.0,
              child: Text(
                "Next",
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: AppColors.appBarButtonColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPhotoInformationScreen(_imageSource)),
              )
            )),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(_prefferedHeigt);
}

class AddPhotoInformationAppBar extends StatelessWidget implements PreferredSizeWidget {

  final double _prefferedHeigt = 88;

  File _imageSource;
  String _name;
  String _description;
  DateTime _uploadDateTime;
  var user;

  AddPhotoInformationAppBar(this._imageSource, this._name,this._description);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            bottom: (BorderSide(
              color: Color(0xFFC4C4C4),
            ))),
        color: Colors.white,
      ),
      height: _prefferedHeigt,
        child: Row(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
                child: Container(
                  margin: EdgeInsets.fromLTRB(20,0,0,16),
                  child: InkWell(
                    child: Icon(Icons.arrow_back_ios,
                    size: 18,),
                    onTap: () => Navigator.pop(context),
                  ),
                )),
            Spacer(flex: 1,),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  height: 46,
                  width: 80,
                  color: Colors.white,
                  child: RaisedButton(
                      color: Colors.white,
                      elevation: 0.0,
                      child: Text(
                        "Add",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: AppColors.appBarButtonColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async{
                        _uploadDateTime = DateTime.now();
                        final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(basename(_imageSource.path));
                        final StorageUploadTask task = firebaseStorageRef.putFile(_imageSource);
                        String downloadUrl = await (await task.onComplete).ref.getDownloadURL();
                        DatabaseService().createPhotoData(_name, _description, downloadUrl,DateFormat("dd-MM-yyyy").format(_uploadDateTime));
                      }
                  )),
            ),
          ],
        ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeigt);
}

