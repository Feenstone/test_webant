import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_webant/resources/app_colors.dart';
import 'package:test_webant/resources/app_strings.dart';
import 'dart:developer' as developer;

class SingleImage extends StatelessWidget {
  final data;

  const SingleImage({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.titleColor,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Image.network(
                data["url"],
                fit: BoxFit.fitWidth,
              ),
              SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  data['name'],
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(data['description'] ??= ' '),
              )
            ],
          )),
    );
  }
}
