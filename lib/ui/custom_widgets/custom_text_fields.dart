import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_webant/resources/app_colors.dart';
import 'package:test_webant/resources/app_strings.dart';
import 'package:test_webant/text_input_assist/focus_change.dart';
import 'package:test_webant/text_input_assist/input_formatter.dart';
import 'package:test_webant/text_input_assist/validator.dart';
import 'dart:developer' as developer;

typedef StringValue = String Function(String);

final FocusNode _passwordConfirmFocus = FocusNode();
final FocusNode _birthDayFocus = FocusNode();
final FocusNode _userNameFocus = FocusNode();
final FocusNode _emailFocus = FocusNode();
final FocusNode _passwordFocus = FocusNode();
final FocusNode _imageNameFocus = FocusNode();
final FocusNode _imageDescriptionFocus = FocusNode();

class UserNameTextFormField extends StatefulWidget {
  @override
  _UserNameTextFormFieldState createState() => _UserNameTextFormFieldState();

  final StringValue callback;

  UserNameTextFormField({@required this.callback});
}

class _UserNameTextFormFieldState extends State<UserNameTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _userNameFocus,
      style: TextStyle(color: Colors.black),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          hintText: AppStrings().userNameHintText,
          hintStyle: TextStyle(color: AppColors.formFieldColor, fontSize: 17),
          suffixIcon: Icon(
            Icons.account_box,
            color: AppColors.formFieldColor,
          )),
      validator: (val) => val.isEmpty || val.length < 5
          ? AppStrings().userNameValidatorText
          : null,
      onChanged: (val) {
        setState(() => widget.callback(val));
      },
      onFieldSubmitted: (term) {
        FocusChange().fieldFocusChange(context, _userNameFocus, _birthDayFocus);
      },
    );
  }
}

class BirthdayTextFormField extends StatefulWidget {
  @override
  _BirthdayTextFormFieldState createState() => _BirthdayTextFormFieldState();

  final StringValue callback;

  BirthdayTextFormField({@required this.callback});
}

class _BirthdayTextFormFieldState extends State<BirthdayTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [
        DateTextFormatter(),
        LengthLimitingTextInputFormatter(10)
      ],
      keyboardType: TextInputType.datetime,
      focusNode: _birthDayFocus,
      textInputAction: TextInputAction.next,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          hintText: AppStrings().birthDayText,
          hintStyle: TextStyle(color: AppColors.formFieldColor, fontSize: 17),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          suffixIcon: Icon(
            Icons.calendar_today,
            color: AppColors.formFieldColor,
          )),
      validator: (val) => !DateValidator().isAdult2(val)
          ? AppStrings().birthDayValidatorText
          : null,
      onChanged: (val) {
        setState(() => widget.callback(val));
      },
      onFieldSubmitted: (term) {
        FocusChange().fieldFocusChange(context, _birthDayFocus, _emailFocus);
      },
    );
  }
}

class EmailTextFormField extends StatefulWidget {
  @override
  _EmailTextFormFieldState createState() => _EmailTextFormFieldState();

  final StringValue callback;

  EmailTextFormField({@required this.callback});
}

class _EmailTextFormFieldState extends State<EmailTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _emailFocus,
      textInputAction: TextInputAction.next,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          hintText: AppStrings().emailHintText,
          hintStyle: TextStyle(color: AppColors.formFieldColor, fontSize: 17),
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
        setState(() => widget.callback(val));
      },
      onFieldSubmitted: (term) {
        FocusChange().fieldFocusChange(context, _emailFocus, _passwordFocus);
      },
    );
  }
}

class PasswordTextFormField extends StatefulWidget {
  @override
  _PasswordTextFormFieldState createState() => _PasswordTextFormFieldState();

  final StringValue callback;

  final TextInputAction inputAction;

  final VoidCallback actionDoneCallback;

  PasswordTextFormField({@required this.callback,@required this.inputAction, this.actionDoneCallback});
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  RegExp exp = RegExp("[A-Z]");

  bool _obscuredPassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _passwordFocus,
      obscureText: _obscuredPassword,
      textInputAction: widget.inputAction,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          hintText: AppStrings().passwordHintText,
          hintStyle: TextStyle(color: AppColors.formFieldColor, fontSize: 17),
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
      validator: (val) {
        if(!exp.hasMatch(val)){
          return AppStrings().passwordValidatorText;
        } if(val.length <8){
          return AppStrings().passwordLengthValidatorText;
        }
        else{
          return null;
        }
      },
      onChanged: (val) {
        setState(() => widget.callback(val));
      },
      onFieldSubmitted: (term) {
        if(widget.actionDoneCallback == null){
          FocusChange()
              .fieldFocusChange(context, _passwordFocus, _passwordConfirmFocus);
        } else{
          widget.actionDoneCallback();
        }
      },
    );
  }
}

//class PasswordConfirmTextFormField extends StatefulWidget {
//  @override
//  _PasswordConfirmTextFormFieldState createState() =>
//      _PasswordConfirmTextFormFieldState();
//
//  final StringValue callback;
//
//  final VoidCallback confirmCallBack;
//
//  final String passwordText;
//
//  final ValueChanged<StringValue> onValueChanged;
//
//  PasswordConfirmTextFormField({@required this.callback,@required this.confirmCallBack,@required this.passwordText, @required this.onValueChanged});
//}
//
//class _PasswordConfirmTextFormFieldState
//    extends State<PasswordConfirmTextFormField> {
//  bool _obscuredPassword = true;
//
//  @override
//  Widget build(BuildContext context) {
//    widget.onValueChanged();
//    return TextFormField(
//      maxLines: 1,
//      obscureText: _obscuredPassword,
//      focusNode: _passwordConfirmFocus,
//      textInputAction: TextInputAction.done,
//      style: TextStyle(color: Colors.black),
//      decoration: InputDecoration(
//          contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 5),
//          hintText: AppStrings().passwordConfirmHintText,
//          hintStyle: TextStyle(color: AppColors.formFieldColor, fontSize: 17),
//          border: OutlineInputBorder(
//            borderRadius: BorderRadius.circular(4),
//          ),
//          suffixIcon: InkWell(
//            onTap: () {
//              setState(() {
//                _obscuredPassword = !_obscuredPassword;
//              });
//            },
//            child: Icon(
//              Icons.remove_red_eye,
//              color: AppColors.formFieldColor,
//            ),
//          )),
//      validator: (val) =>
//          val != widget.passwordText ? AppStrings().passwordConfirmValidatorText : null,
//      onChanged: (val) {
//        setState(() => widget.callback(val));
//      },
//      onFieldSubmitted: (val) async => widget.confirmCallBack(),
//    );
//  }
//}

class ImageNameTextFormField extends StatefulWidget {

  final StringValue callback;

  ImageNameTextFormField({this.callback});

  @override
  _ImageNameTextFormFieldState createState() => _ImageNameTextFormFieldState();
}

class _ImageNameTextFormFieldState extends State<ImageNameTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _imageNameFocus,
      textInputAction: TextInputAction.next,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        contentPadding:
        EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        hintText: AppStrings().imageNameHintText,
        hintStyle: TextStyle(
            color: AppColors.formFieldColor, fontSize: 17),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      onChanged: (val) {
        setState(() => widget.callback(val));
      },
      validator: (val) =>
      val.isEmpty ? AppStrings().imageValidatorText : null,
      onFieldSubmitted: (term) {
        FocusChange().fieldFocusChange(context, _imageNameFocus, _imageDescriptionFocus);
      },
    );
  }
}

class ImageDescriptionTextFormField extends StatefulWidget {

  final StringValue callback;

  ImageDescriptionTextFormField({@required this.callback});

  @override
  _ImageDescriptionTextFormFieldState createState() => _ImageDescriptionTextFormFieldState();
}

class _ImageDescriptionTextFormFieldState extends State<ImageDescriptionTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _imageDescriptionFocus,
      style: TextStyle(color: Colors.black),
      maxLines: 4,
      decoration: InputDecoration(
        contentPadding:
        EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        hintText: AppStrings().imageDescriptionText,
        hintStyle: TextStyle(
            color: AppColors.formFieldColor, fontSize: 17),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      onChanged: (val) {
        setState(() => widget.callback(val));
      },
    );
  }
}


