

import 'package:test_webant/features/gallery/domain/entities/photo.dart';

class PhotoModel extends Photo {
  var data;
  int id;
  String name;
  String description;
  bool newest;
  bool popular;
  var image;

  PhotoModel(
      {this.id,
      this.name,
      this.description,
      this.newest,
      this.popular,
      this.data,
      this.image})
      : super(
            id: id,
            name: name,
            description: description,
            newest: newest,
            popular: popular,
            data: data,
            image: image);

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      data: json['data'],
      id: json['id'],
      name: json['name'],
      description: json['description'],
      newest: json['new'],
      popular: json['popular'],
      image: json['image']['name'],
    );
  }
}
