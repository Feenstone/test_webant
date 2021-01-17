import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:http/http.dart' as http;
import 'package:test_webant/features/gallery/domain/entities/photo.dart';
import 'package:test_webant/providers.dart';

class SingleImage extends StatelessWidget {
  final Photo photo;

  const SingleImage({
    Key key,
    @required this.photo,
  }) : super(key: key);

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.network(
                'http://gallery.dev.webant.ru/media/' + photo.image,
                fit: BoxFit.fitWidth,
              ),
              SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  photo.name,
                  style: TextStyle(fontSize: 20.0, color: Color(0xFF2F1767)),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(photo.description),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
