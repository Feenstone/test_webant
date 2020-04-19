import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:test_webant/resources/app_colors.dart';
import 'package:test_webant/resources/app_strings.dart';
import 'package:test_webant/services/auth.dart';
import 'package:test_webant/ui/custom_widgets/custom_app_bar.dart';
import 'package:test_webant/ui/custom_widgets/custom_buttons.dart';
import 'package:test_webant/ui/custom_widgets/custom_text_fields.dart';
import 'package:test_webant/ui/scenes/main_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = AuthService();

  final _formkey = GlobalKey<FormState>();

  String _userName;
  String _birthday;
  String _email;
  String _password;
  String _passwordConfirm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GallerySignInAppBar(),
      backgroundColor: Colors.white,
      body: Form(
        key: _formkey,
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Center(
                child: Text(
                  AppStrings().signUpButtonText,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.underlineColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              UserNameTextFormField(callback: (val) => _userName = val),
              SizedBox(
                height: 30,
              ),
              BirthdayTextFormField(callback: (val) => _birthday = val),
              SizedBox(
                height: 30,
              ),
              EmailTextFormField(callback: (val) => _email = val),
              SizedBox(
                height: 30,
              ),
              PasswordTextFormField(callback: (val) => _password = val, inputAction: TextInputAction.next,),
              SizedBox(
                height: 30,
              ),
              PasswordConfirmTextFormField(
                callback: (val) => _passwordConfirm = val,
                confirmCallBack: () async => signUpComplete(),
                passwordText: _password,
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: BlackSignUpButton(
                    pressedCallBack: () async => signUpComplete()),
              ),
              SizedBox(
                height: 10,
              ),
              WhiteSignInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signUpComplete() async {
    if (_formkey.currentState.validate()) {
      dynamic result = await _auth.registerWithEmailAndPassword(
          _email, _password, _userName, _birthday);
      if (result == null) {
        setState(() {});
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
          (Route<dynamic> route) => false,
        );
      }
      return null;
    }
  }
}
