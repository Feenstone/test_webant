import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test_webant/resources/app_colors.dart';
import 'package:test_webant/resources/app_strings.dart';
import 'package:test_webant/services/auth.dart';
import 'package:test_webant/ui/custom_widgets/custom_app_bar.dart';
import 'package:test_webant/ui/custom_widgets/custom_buttons.dart';
import 'package:test_webant/ui/scenes/main_screen.dart';
import 'package:test_webant/ui/scenes/split_gallery_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FocusNode _userNameFocus = FocusNode();
  final FocusNode _birthDayFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _passwordConfirmFocus = FocusNode();
  final _formkey = GlobalKey<FormState>();
  final _auth = AuthService();

  String _userName;
  String _birthday;
  String _email;
  String _password;
  String _passwordConfirm;

  bool _obscuredPassword = true;

  RegExp exp = RegExp(r"(?!^.*[A-Z]{2,}.*$)^[A-Za-z]*$");

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
              Container(
                height: 36,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppColors.formFieldColor)),
                margin: EdgeInsets.fromLTRB(16, 0, 16, 30),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  focusNode: _userNameFocus,
                  style: TextStyle(color: Colors.black),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: "User Name",
                      hintStyle: TextStyle(
                          color: AppColors.formFieldColor, fontSize: 17),
                      border: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.account_box,
                        color: AppColors.formFieldColor,
                      )),
                  validator: (val) => val.isEmpty || val.length < 5
                      ? 'username should contain 5 or more letters'
                      : null,
                  onChanged: (val) {
                    setState(() => _userName = val);
                  },
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, _userNameFocus, _birthDayFocus);
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
                  keyboardType: TextInputType.datetime,
                  focusNode: _birthDayFocus,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      hintText: "Birthday",
                      hintStyle: TextStyle(
                          color: AppColors.formFieldColor, fontSize: 17),
                      border: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        color: AppColors.formFieldColor,
                      )),
                  onChanged: (val) {
                    setState(() => _birthday = val);
                  },
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, _birthDayFocus, _emailFocus);
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
                  validator: (val) => (exp.hasMatch(val) && val.length < 8)
                      ? ('use at least 1 capital letter')
                      : null,
                  onChanged: (val) {
                    setState(() => _password = val);
                  },
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(
                        context, _passwordFocus, _passwordConfirmFocus);
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
                  obscureText: _obscuredPassword,
                  focusNode: _passwordConfirmFocus,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      hintText: "Confirm password",
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
                  validator: (val) =>
                      val != _password ? 'passwords doesnt match' : null,
                  onChanged: (val) {
                    setState(() => _passwordConfirm = val);
                  },
                  onFieldSubmitted: (term) async {
                    if (_formkey.currentState.validate()) {
                      dynamic result =
                      await _auth.registerWithEmailAndPassword(
                          _email, _password, _userName);
                      if (result == null) {
                        setState(() {});
                      } else {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SplitGalleryScreen()),
                              (Route<dynamic> route) => false,
                        );
                      }
                      return null;
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
                        dynamic result =
                            await _auth.registerWithEmailAndPassword(
                                _email, _password, _userName);
                        if (result == null) {
                          setState(() {});
                        } else {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SplitGalleryScreen()),
                            (Route<dynamic> route) => false,
                          );
                        }
                        return null;
                      }
                    },
                    child: Text(
                      AppStrings().signUpButtonText,
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
              WhiteSignInButton(),
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
