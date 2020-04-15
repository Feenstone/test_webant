import 'dart:io';

import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import 'package:test_webant/resources/app_colors.dart';
import 'package:test_webant/resources/app_strings.dart';
import 'package:test_webant/ui/scenes/create_photo_screen.dart';
import 'package:test_webant/ui/scenes/sign_in_screen.dart';
import 'package:test_webant/ui/scenes/sign_up_screen.dart';

class AlreadyHaveAnAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      margin: EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: RaisedButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side: BorderSide(color: Colors.black),
        ),
        color: Colors.white,
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SignInScreen(),
              ),
          );
        },
        child: Text(
          AppStrings().alreadyHaveAnAccountButtonText,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class CreateAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      margin: EdgeInsets.fromLTRB(16, 40, 16, 10),
      child: RaisedButton(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        color: AppColors.buttonColor,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SignUpScreen(),
            )
          );
        },
        child: Text(
          AppStrings().createAccountButtonText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class BlackSignInButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 36,
        width: 120,
        child: RaisedButton(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          color: AppColors.buttonColor,
          onPressed: () {},
          child: Text(
            AppStrings().signInButtonText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
      ),
    );
  }
}
//
//class BlackSignUpButton extends StatelessWidget {
//
//  GlobalKey _formkey = GlobalKey<FormState>();
//
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Form(
//      key: _formkey,
//      child: Center(
//        child: Container(
//          height: 36,
//          width: 120,
//          child: RaisedButton(
//            elevation: 0,
//            key: _formkey,
//            shape:
//            RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
//            color: AppColors.buttonColor,
//            onPressed: () {
//              if (_formkey.currentState.validate()) {
//                Scaffold.of(context)
//                    .showSnackBar(SnackBar(content: Text('Processing Data')));
//              }
//            },
//            child: Text(
//              AppStrings().signUpButtonText,
//              style: TextStyle(
//                color: Colors.white,
//                fontSize: 17,
//                fontWeight: FontWeight.bold,
//                fontStyle: FontStyle.normal,
//              ),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}

class WhiteSignInButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 36,
        width: 120,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          elevation: 0,
          color: Colors.white,
          onPressed: () {},
          child: Text(
            AppStrings().signInButtonText,
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
      ),
    );
  }
}

class WhiteSignUpButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 36,
        width: 120,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          elevation: 0,
          color: Colors.white,
          onPressed: () {},
          child: Text(
            AppStrings().signUpButtonText,
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
      ),
    );
  }
}

//class SelectPhotoButton extends StatefulWidget {
//  @override
//  _SelectPhotoButtonState createState() => _SelectPhotoButtonState();
//}
//
//class _SelectPhotoButtonState extends State<SelectPhotoButton> {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      height: 36,
//      margin: EdgeInsets.fromLTRB(16, 40, 16, 10),
//      decoration: BoxDecoration(
//          border: Border.all(color: Colors.black)
//      ),
//      child: RaisedButton(
//        elevation: 0,
//        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
//        color: Colors.white,
//        onPressed: () => _pickImage(ImageSource.gallery),
//        child: Text(
//          'Select Photo',
//          style: TextStyle(
//            color: Colors.black,
//            fontSize: 14,
//          ),
//        ),
//      ),
//    );
//  }
//
//  Future<void> _pickImage(ImageSource source) async {
//    File selected = await ImagePicker.pickImage(source: source);
//
//    setState(() {
//      CreatePhotoScreen()._imageSource = selected;
//    });
//  }
//}
