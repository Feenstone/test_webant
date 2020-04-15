import 'package:flutter/material.dart';
import 'package:test_webant/resources/app_colors.dart';
import 'package:test_webant/resources/app_strings.dart';

class NoInternetConnectionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Container(
              height: 70,
              width: 70,
              child: Image(
                image: AssetImage(AppStrings().noInternetAssetRoot),
                fit: BoxFit.fill,
              )),
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.center,
          child: Text(
            AppStrings().errorTextHeader,
            style: TextStyle(
              fontSize: 17.0,
            ),
          ),
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.center,
          child: Text(
            AppStrings().errorTextDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
                color: AppColors.formFieldColor
            ),
          ),
        )
      ],
    );
  }
}
