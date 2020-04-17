import 'package:flutter/material.dart';
import 'package:test_webant/Resources/app_strings.dart';
import 'package:test_webant/Ui/Scenes/single_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:test_webant/services/database.dart';

class PhotoGridView extends StatelessWidget{

  final data;
  final scrollController;

  PhotoGridView(this.data,this.scrollController);

  @override
  Widget build(BuildContext context){
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 166.21 / 166.21,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
            semanticContainer: true,
            elevation: 5.7,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.all(6.0),
            child: GestureDetector(
              child: CachedNetworkImage(
                imageUrl: (data[index]["url"]),
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              onTap: () async {
                int watchCount = data[index]['watchCount'];
                watchCount++;
                if(watchCount >= 10){
                 await DatabaseService().photoCollection.document(data[index]['name']).updateData(<String,dynamic>{
                    "type": "popular"
                  });
                }
                    await DatabaseService().photoCollection.document(data[index]['name']).updateData(<String,dynamic>{
                  "watchCount": watchCount
                });
                _navigateToImage(context, data[index]);
              },
            ),
          );
        },
        controller: scrollController,
      );
    }
  }



  void _navigateToImage(BuildContext context, dynamic data) {
   Navigator.of(context).push(
     MaterialPageRoute(
       builder: (context) => SingleImage(data: data,),
     ),
   );
 }
