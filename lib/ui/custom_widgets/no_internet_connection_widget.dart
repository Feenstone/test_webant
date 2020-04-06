import 'package:flutter/material.dart';
import 'package:test_webant/Resources/app_colors.dart';


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
              child: Image(image: AssetImage('assets/no_internet.png'), fit: BoxFit.fill,)
          ),
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.center,
          child: Text('Oh shucks!',
            style: TextStyle(
              fontSize: 20.0,
              color: AppColors.titleColor,
            ),
          ),
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.center,
          child: Text(('Slow or no internet connection.'+'\n'+'Please check your internet settings'),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12,
                color: Color(0xFF4A4A4A)
            ),
          ),
        )
      ],
    );
  }

}