import 'package:flutter/material.dart';
import 'package:test_webant/resources/app_strings.dart';
import 'package:test_webant/ui/custom_widgets/custom_buttons.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            SizedBox(
              height: 208,
            ),
            Container(
              height: 150,
              width: 150,
              child: Image(
                image: AssetImage(AppStrings().webAntLogoAssetRoot),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                AppStrings().welcomeText,
                style: TextStyle(
                    fontSize: 29,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            CreateAccountButton(),
            AlreadyHaveAnAccountButton(),
          ],
        ),
      ),
    );
  }
}
