import "package:flutter/material.dart";
import 'package:test_webant/resources/app_colors.dart';
import 'package:test_webant/resources/app_strings.dart';
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
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => SignInScreen()),);
          },
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
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => SignUpScreen()),);
          },
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