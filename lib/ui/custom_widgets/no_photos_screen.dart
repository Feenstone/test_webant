import 'package:flutter/material.dart';
import 'package:test_webant/resources/app_colors.dart';
import 'package:test_webant/resources/app_strings.dart';

class NoPhotosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Container(
              height: 150,
              width: 150,
              child: Image(
                image: AssetImage(AppStrings().errorIconAssetRoot),
                fit: BoxFit.fill,
              )),
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.center,
          child: Text(
            AppStrings().noPhotoTextHeader,
            style: TextStyle(
              fontSize: 17.0,
              color: AppColors.formFieldColor
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
