import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_webant/ui/scenes/main_screen.dart';
import 'package:test_webant/ui/scenes/split_gallery_screen.dart';
import 'package:test_webant/ui/scenes/welcome_screen.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser>(context);

    if (user == null){
      return WelcomeScreen();
    } else{
     return MainScreen();
    }
  }
}
