import 'package:flutter/material.dart';

class Photo {
  final data;
  final int id;
  final String name;
  final String description;
  final bool newest;
  final bool popular;
  final image;

  Photo({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.newest,
    @required this.popular,
    @required this.data,
    @required this.image,
  });
}
