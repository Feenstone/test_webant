import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_webant/resources/app_colors.dart';
import 'package:test_webant/resources/app_strings.dart';
import 'package:test_webant/services/auth.dart';
import 'package:test_webant/ui/custom_widgets/custom_app_bar.dart';
import 'package:test_webant/ui/custom_widgets/custom_buttons.dart';
import 'package:test_webant/ui/custom_widgets/custom_text_fields.dart';
import 'package:test_webant/ui/scenes/main_screen.dart';
import 'dart:developer' as developer;

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formkey = GlobalKey<FormState>();
  final _auth = AuthService();

  String _email = '';
  String _password = '';
  String _error = '';
  RegExp exp = RegExp(r"(?!^.*[A-Z]{2,}.*$)^[A-Za-z]*$");

  bool _obscuredPassword = true;

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

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
                  AppStrings().signInButtonText,
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
              EmailTextFormField(callback: (val) => _email = val),
              SizedBox(
                height: 30,
              ),
              PasswordTextFormField(
                  callback: (val) => _password = val,
                  inputAction: TextInputAction.done,
                  actionDoneCallback: () async => signInComplete()),
              SizedBox(
                height: 50,
              ),
              Center(
                  child: BlackSignUpButton(
                pressedCallBack: () => signInComplete(),
              )),
              SizedBox(
                height: 10,
              ),
              WhiteSignUpButton(),
              Center(
                child: Text(
                  _error,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signInComplete() async {
    if (_formkey.currentState.validate()) {
      dynamic result =
          await _auth.signInWithEmailAndPassword(_email, _password);
      if (result == null) {
        setState(() {
          _error = AppStrings().errorSignInMessage;
        });
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
          (Route<dynamic> route) => false,
        );
      }
    }
  }
}
