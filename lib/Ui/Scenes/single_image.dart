import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SingleImage extends StatelessWidget {
  final int imageId;

  const SingleImage({Key key, this.imageId,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xFF2F1767),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<Map>(
          future: _fetchPhoto(imageId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final Map data = snapshot.data;
              return _buildImage(data);
            }
            else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }
      ),
    );
  }

  Future<Map> _fetchPhoto(int imageId) async {
    final galleryUrl = "http://gallery.dev.webant.ru/api/photos/"+imageId.toString();
    final response = await http.get(galleryUrl);

    if (response.statusCode == 200) {
      Map photo = json.decode(response.body);
      return photo;
    }
    else {
      throw Exception('Failed to load photo from API');
    }
  }

  Padding _buildImage(Map photo){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: <Widget>[
          Image.network('http://gallery.dev.webant.ru/media/'+photo['image']['name'], fit: BoxFit.fitWidth,),
          SizedBox(height: 8,),
          Align(
            alignment: Alignment.centerLeft,
           child: Text(photo['name'],
           style: TextStyle(
             fontSize: 20.0,
             color: Color(0xFF2F1767)
           ),),
          ),
          SizedBox(height: 8,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(photo['description']!= null? photo['description'] : ' '),
          )
        ],
      )
    );
  }

}