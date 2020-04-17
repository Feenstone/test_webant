import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:test_webant/resources/app_colors.dart';
import 'package:test_webant/resources/app_strings.dart';
import 'package:test_webant/services/auth.dart';
import 'package:test_webant/text_input_assist/focus_change.dart';
import 'package:test_webant/text_input_assist/input_formatter.dart';
import 'package:test_webant/text_input_assist/validator.dart';
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

  String userName;
  String birthday;
  String email;
  String password;
  String passwordConfirm;

  bool _obscuredPassword = true;

  RegExp exp = RegExp(r"(?!^.*[A-Z]{2,}.*$)^[A-Za-z]*$", caseSensitive: true);

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
              TextFormField(
                focusNode: _userNameFocus,
                style: TextStyle(color: Colors.black),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    hintText: AppStrings().userNameHintText,
                    hintStyle: TextStyle(
                        color: AppColors.formFieldColor, fontSize: 17),
                    suffixIcon: Icon(
                      Icons.account_box,
                      color: AppColors.formFieldColor,
                    )),
                validator: (val) => val.isEmpty || val.length < 5
                    ? AppStrings().userNameValidatorText
                    : null,
                onChanged: (val) {
                  setState(() => userName = val);
                },
                onFieldSubmitted: (term) {
                  FocusChange().fieldFocusChange(
                      context, _userNameFocus, _birthDayFocus);
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                inputFormatters: [
                  DateTextFormatter(),
                  LengthLimitingTextInputFormatter(10)
                ],
                keyboardType: TextInputType.datetime,
                focusNode: _birthDayFocus,
                textInputAction: TextInputAction.next,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    hintText: AppStrings().birthDayText,
                    hintStyle: TextStyle(
                        color: AppColors.formFieldColor, fontSize: 17),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: AppColors.formFieldColor,
                    )),
                validator: (val) => !DateValidator().isAdult2(birthday)
                    ? AppStrings().birthDayValidatorText
                    : null,
                onChanged: (val) {
                  setState(() => birthday = val);
                },
                onFieldSubmitted: (term) {
                  FocusChange()
                      .fieldFocusChange(context, _birthDayFocus, _emailFocus);
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                focusNode: _emailFocus,
                textInputAction: TextInputAction.next,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    hintText: AppStrings().emailHintText,
                    hintStyle: TextStyle(
                        color: AppColors.formFieldColor, fontSize: 17),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    suffixIcon: Icon(
                      Icons.mail_outline,
                      color: AppColors.formFieldColor,
                    )),
                validator: (val) =>
                    !val.contains('@') ? AppStrings().emailValidatorText : null,
                onChanged: (val) {
                  setState(() => email = val);
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
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    hintText: AppStrings().passwordHintText,
                    hintStyle: TextStyle(
                        color: AppColors.formFieldColor, fontSize: 17),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
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
                    ? AppStrings().passwordValidatorText
                    : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
                onFieldSubmitted: (term) {
                  FocusChange().fieldFocusChange(
                      context, _passwordFocus, _passwordConfirmFocus);
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                maxLines: 1,
                obscureText: _obscuredPassword,
                focusNode: _passwordConfirmFocus,
                textInputAction: TextInputAction.done,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 6, horizontal: 5),
                    hintText: AppStrings().passwordConfirmHintText,
                    hintStyle: TextStyle(
                        color: AppColors.formFieldColor, fontSize: 17),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
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
                    val != password ? AppStrings().passwordValidatorText : null,
                onChanged: (val) {
                  setState(() => passwordConfirm = val);
                },
                onFieldSubmitted: (term) async => signUpComplete(),
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
                    onPressed: () async => signUpComplete(),
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

  Future<void> signUpComplete() async {
    if (_formkey.currentState.validate()) {
      dynamic result = await _auth.registerWithEmailAndPassword(
          email, password, userName, birthday);
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
