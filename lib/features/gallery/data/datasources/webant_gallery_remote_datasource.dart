import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:test_webant/core/errors/exceptions.dart';
import 'package:test_webant/features/gallery/data/models/photo_model.dart';
import 'package:test_webant/features/gallery/domain/entities/photo.dart';


abstract class WebantGalleryRemoteDataSource {
  Future<List<PhotoModel>> getNewPhotos(int page);
  Future<List<PhotoModel>> getPopularPhotos(int page);
  Future<PhotoModel> getSinglePhoto(int imageId);
}

class WebantGalleryRemoteDataSourceImpl implements WebantGalleryRemoteDataSource {
  final http.Client client;

  WebantGalleryRemoteDataSourceImpl({@required this.client});

  @override
  Future<List<PhotoModel>> getNewPhotos(int page) => _getPhotosFromUrl("http://gallery.dev.webant.ru/api/photos?new=true", page);

  @override
  Future<List<PhotoModel>> getPopularPhotos(int page) => _getPhotosFromUrl("http://gallery.dev.webant.ru/api/photos?popular=true", page);

  @override
  Future<PhotoModel> getSinglePhoto(int imageId) async {
    final response = await client.get("http://gallery.dev.webant.ru/api/photos/"+imageId.toString());

    if(response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      return PhotoModel.fromJson(decodedJson);
    } else {
      throw ServerException();
    }
  }

  Future<List<PhotoModel>> _getPhotosFromUrl(String url, int page) async {
    final response = await client.get(url+"&page=${page.toString()}"+"&limit=10");

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      List<Photo> result = (decodedJson['data'] as List).map((photo) => PhotoModel.fromJson(photo)).toList();
      return result;
    } else {
      throw ServerException();
    }
  }
}