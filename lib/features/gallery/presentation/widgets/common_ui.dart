import 'package:flutter/material.dart';
import 'package:test_webant/features/gallery/presentation/pages/single_image.dart';

class NoInternetConnection extends StatelessWidget {
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
              child: Image(image: AssetImage('assets/no_internet.png'), fit: BoxFit.fill,)
          ),
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.center,
          child: Text('Oh shucks!',
            style: TextStyle(
                fontSize: 20.0,
                color: Color(0xFF2F1767)
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