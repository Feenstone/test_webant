import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_webant/bloc/user_photo_block.dart';
import 'package:test_webant/resources/app_colors.dart';
import 'package:test_webant/services/database.dart';
import 'package:test_webant/ui/custom_widgets/custom_app_bar.dart';


class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  var documentList;
  int averageWatchCount;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    var userInfo = DatabaseService().userCollection.document(user.uid).snapshots();
    return StreamBuilder(
        stream: userInfo,
        builder: (context, snapshot) {
          try{
          UserPhotoBloc().getUserPhotos(snapshot.data);
          return Scaffold(
            appBar: UserInformationAppBar(),
            body: ListView(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    child: CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.camera_alt,
                        color: AppColors.appBarIconColor,
                        size: 53,
                      ),
                    ),
                    padding: const EdgeInsets.all(1.0),
                    decoration: new BoxDecoration(
                      color: AppColors.formFieldColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    snapshot.data['name'].toString(),
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Center(
                  child: Text(
                    snapshot.data['birthday'].toString(),
                    style:
                        TextStyle(fontSize: 12, color: AppColors.formFieldColor),
                  ),
                ),
                SizedBox(
                  height: 27,
                ),
              ],
            ),
          );
        }catch(e){
            return CircularProgressIndicator();
          }
        });
  }
}
