import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_webant/resources/app_colors.dart';
import 'package:test_webant/services/database.dart';
import 'package:test_webant/ui/custom_widgets/custom_app_bar.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    return Scaffold(
      appBar: UserInformationAppBar(),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20,),
          Center(
            child: Container(
              child: CircleAvatar(
                radius: 75,
                backgroundColor: Colors.white,
                child: Icon(Icons.camera_alt, color: AppColors.appBarIconColor, size: 53,),
              ),
                padding: const EdgeInsets.all(1.0),
                decoration: new BoxDecoration(
                  color: AppColors.formFieldColor,
                  shape: BoxShape.circle,
                )
            ),
          ),
          SizedBox(height: 10,),
        ],
      )
    );
  }
}
