import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:test_webant/resources/app_colors.dart';
import 'package:test_webant/resources/app_strings.dart';
import 'package:test_webant/ui/scenes/add_photo_information_screen.dart';
import 'package:test_webant/ui/scenes/user_redactor_screen.dart';

typedef StringValue = String Function(String);

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
                    hintText: AppStrings().searchBarHintText,
                    hintStyle: TextStyle(
                        color: AppColors.formFieldColor, fontSize: 17),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.appBarIconColor,
                    ),
                    suffixIcon: Icon(
                      Icons.mic,
                      color: AppColors.appBarIconColor,
                    )),
                onChanged: (val) {
                  setState(() => _searchText = val);
                },
              ),
            ),
          ),
          TabBar(
            tabs: <Tab>[
              Tab(
                text: AppStrings().newGalleryGridTitle,
              ),
              Tab(
                text: AppStrings().popularGalleryGridTitle,
              )
            ],
            labelColor: Colors.black,
            controller: widget.tabController,
            unselectedLabelStyle: TextStyle(color: AppColors.formFieldColor, fontSize: 17),
            labelStyle: TextStyle(fontSize: 17),
              indicatorColor: AppColors.appBarButtonColor,
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
          color: AppColors.formFieldColor,
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
                AppStrings().cancelButtonText,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: AppColors.cancelButtonColor,
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

  final File imageSource;
  CreatePhotoAppBar({this.imageSource});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            bottom: (BorderSide(
              color: AppColors.formFieldColor,
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
                AppStrings().nextButtonText,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: AppColors.appBarButtonColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
              if(imageSource != null){
                  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPhotoInformationScreen(imageSource)));
                }
              }
              ),
            )),
      );
  }

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeigt);
}

class AddPhotoInformationAppBar extends StatelessWidget implements PreferredSizeWidget {

  final double _prefferedHeigt = 88;

  final VoidCallback callback;

  AddPhotoInformationAppBar({this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            bottom: (BorderSide(
              color: AppColors.formFieldColor,
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
                        AppStrings().addButtonText,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: AppColors.appBarButtonColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async {
                        callback();
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

class UserInformationAppBar extends StatelessWidget implements PreferredSizeWidget {

  final double _prefferedHeigt = 88;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            bottom: (BorderSide(
              color: AppColors.formFieldColor,
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
              margin: EdgeInsets.fromLTRB(0,0,20,16),
              child: InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserRedactorScreen()),),
                child: Icon(Icons.settings),
              ) ,
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeigt);
}