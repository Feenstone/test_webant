import 'package:flutter/material.dart';
import 'package:test_webant/resources/app_colors.dart';
import 'package:test_webant/resources/app_strings.dart';
import 'package:test_webant/services/auth.dart';
import 'package:test_webant/ui/custom_widgets/custom_app_bar.dart';
import 'package:test_webant/ui/custom_widgets/custom_buttons.dart';
import 'package:test_webant/ui/scenes/main_screen.dart';
import 'package:test_webant/ui/scenes/split_gallery_screen.dart';
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
              Container(
                height: 36,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppColors.formFieldColor)),
                margin: EdgeInsets.fromLTRB(16, 0, 16, 30),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  focusNode: _emailFocus,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(
                          color: AppColors.formFieldColor, fontSize: 17),
                      border: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.mail_outline,
                        color: AppColors.formFieldColor,
                      )),
                  validator: (val) =>
                      !val.contains('@') ? 'enter an email' : null,
                  onChanged: (val) {
                    setState(() => _email = val);
                  },
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, _emailFocus, _passwordFocus);
                  },
                ),
              ),
              Container(
                height: 36,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppColors.formFieldColor)),
                margin: EdgeInsets.fromLTRB(16, 0, 16, 30),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  focusNode: _passwordFocus,
                  obscureText: _obscuredPassword,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(
                          color: AppColors.formFieldColor, fontSize: 17),
                      border: InputBorder.none,
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            _obscuredPassword = !_obscuredPassword;
                          });
                        },
                        child: Icon(
                          Icons.remove_red_eye,
                          color: AppColors.formFieldColor,
                        ),
                      )),
                  onChanged: (val) {
                    setState(() => _password = val);
                  },
                  onFieldSubmitted: (term) async {
                    _passwordFocus.unfocus();
                    if (_formkey.currentState.validate()) {
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          _email, _password);
                      developer.log(result.toString());
                      if (result == null) {
                        setState(() {
                          _error = ('Could not sign in with those credentials');
                        });
                      } else {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SplitGalleryScreen()),
                          (Route<dynamic> route) => false,
                        );
                      }
                    }
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Container(
                  height: 36,
                  width: 120,
                  child: RaisedButton(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                    color: AppColors.buttonColor,
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        dynamic result = await _auth.signInWithEmailAndPassword(
                            _email, _password);
                        developer.log(result.toString());
                        if (result == null) {
                          setState(() {
                            _error =
                                ('Could not sign in with those credentials');
                          });
                        } else {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen()),
                            (Route<dynamic> route) => false,
                          );
                        }
                      }
                    },
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
              ),
              SizedBox(
                height: 10,
              ),
              WhiteSignUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
