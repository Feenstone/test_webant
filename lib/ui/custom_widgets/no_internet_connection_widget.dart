import 'package:flutter/material.dart';
import 'package:test_webant/resources/app_colors.dart';
import 'package:test_webant/resources/app_strings.dart';


class NoInternetConnection{

  Column noInternetConnection(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Container(
              height: 150,
              width: 150,
              child: Image(image: AssetImage(AppStrings().noInternetAssetRoot), fit: BoxFit.fill,)
          ),
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.center,
          child: Text(AppStrings().errorTextHeader,
            style: TextStyle(
              fontSize: 20.0,
              color: AppColors.titleColor,
            ),
          ),
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.center,
          child: Text(AppStrings().errorTextDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12,
                color: AppColors.errorDescriptionTextColor,
            ),
          ),
        )
      ],
    );
  }

}