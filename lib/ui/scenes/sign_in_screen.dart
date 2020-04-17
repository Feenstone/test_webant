import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_webant/resources/app_colors.dart';
import 'package:test_webant/resources/app_strings.dart';
import 'package:test_webant/services/auth.dart';
import 'package:test_webant/text_input_assist/focus_change.dart';
import 'package:test_webant/ui/custom_widgets/custom_app_bar.dart';
import 'package:test_webant/ui/custom_widgets/custom_buttons.dart';
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
              TextFormField(
                focusNode: _emailFocus,
                textInputAction: TextInputAction.next,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    hintText: AppStrings().emailHintText,
                    hintStyle: TextStyle(
                        color: AppColors.formFieldColor, fontSize: 17),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    suffixIcon: Icon(
                      Icons.mail_outline,
                      color: AppColors.formFieldColor,
                    )),
                validator: (val) =>
                    !val.contains('@') ? AppStrings().emailValidatorText : null,
                onChanged: (val) {
                  setState(() => _email = val);
                },
                onFieldSubmitted: (term) {
                  FocusChange()
                      .fieldFocusChange(context, _emailFocus, _passwordFocus);
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                  focusNode: _passwordFocus,
                  obscureText: _obscuredPassword,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black),
                  validator: (val) => (exp.hasMatch(val) && val.length < 8)
                      ? AppStrings().passwordValidatorText
                      : null,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      hintText: AppStrings().passwordHintText,
                      hintStyle: TextStyle(
                          color: AppColors.formFieldColor, fontSize: 17),
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
                  onFieldSubmitted: (term) => signInComplete()),
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
                    onPressed: () => signInComplete(),
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
      developer.log(result.toString());
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
